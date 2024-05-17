import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;

class NoDevicePlogging extends StatefulWidget {
  const NoDevicePlogging({
    super.key,
  });

  @override
  State<NoDevicePlogging> createState() => _NoDeviceState();
}

class _NoDeviceState extends State<NoDevicePlogging> {
  late MainProvider mainProvider;
  late UserProvider userProvider;

  late PetModel petModel;
  late Map<String, dynamic> currentPet;

  late double latitude;
  late double longitude; // 현재 위치 위도 경도를 업데이트 해 줄 변수
  double previousLatitude = 0;
  double previousLongitude = 0; // 직전 위도 경도 변수
  final List<NLatLng> _pathPoints = []; // 실시간 경로를 저장할 변수
  late StreamSubscription<Position> pathStream; // 실시간 경로 받아오는 stream 객체 변수
  double totalDistance = 0;
  bool _isLocationLoaded = false; // 위치 데이터 로드 상태를 추적하는 플래그
  NaverMapController? _mapController; // 지도 컨트롤러를 옵셔널로 선언
  bool isSelectedTrashTong = false;
  final double _currentZoom = 15.0; // 클러스터링 초기 줌 레벨 설정
  List<NMarker> trashTongs = []; // 쓰레기통 마커 변수

  // api 응답 관련 변수
  late PloggingModel ploggingModel;
  late int ploggingId;
  late String accessToken;

  late bool memberTutorial;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    memberTutorial = userProvider.getMemberTutorial();
    petModel = Provider.of<PetModel>(context, listen: false);
    currentPet = petModel.getCurrentPet();
    accessToken = userProvider.getAccessToken();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    getPathLocation();
    realTimePath();
  }

  // 위젯 제거 될 때 controller 제거, Stream 구독 취소
  @override
  void dispose() {
    pathStream.cancel();
    _mapController!.dispose();
    super.dispose();
  }

  // 현재 위치 조회하는 함수
  getPathLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _pathPoints.add(NLatLng(position.latitude, position.longitude));
      _isLocationLoaded = true;
    });
    print('현재 위치 : ${position.latitude}, ${position.longitude}');
  }

// 실시간으로 경로 받아오는 함수
  realTimePath() {
    // distanceFilter의 거리 이동 시 계속해서 위치를 받아옴
    pathStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(distanceFilter: 20))
        .listen((Position position) {
      setState(() {
        previousLatitude = _pathPoints.last.latitude;
        previousLongitude = _pathPoints.last.longitude;
        latitude = position.latitude;
        longitude = position.longitude;

        _pathPoints.add(NLatLng(latitude, longitude)); // 받아온 위치 추가하는 부분

        double distanceInMeters = Geolocator.distanceBetween(
            previousLatitude, previousLongitude, latitude, longitude);
        totalDistance += distanceInMeters; // 총거리에 더해주기
        print(
            '경로 : $previousLatitude, $previousLongitude -> $latitude, $longitude, 거리 : $distanceInMeters 총 거리 : $totalDistance');
      });
      _mapController!.addOverlay(NPathOverlay(
        id: 'realtime',
        width: 5,
        coords: _pathPoints,
        color: AppColors.basicgreen,
      ));
    });
  }

  // 지도에서 다른 화면을 보다가 현재 위치로 돌아오는 함수
  void returnCurrentLocation() async {
    await getPathLocation();
    print('현재 위치로 $latitude랑 $longitude');
    await _mapController!.updateCamera(NCameraUpdate.withParams(
        target: NLatLng(latitude, longitude), zoom: 15, bearing: 0, tilt: 45));
    _mapController!.setLocationTrackingMode(NLocationTrackingMode.face);
  }

  Future<List<dynamic>> readJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/trash_tong_data.json');
    return jsonDecode(jsonString);
  }

  void trashTongToggle() {
    setState(() {
      isSelectedTrashTong = !isSelectedTrashTong;
    });
    updateMarkers();
  }

  void createTrashtongMarkers() async {
    if (_mapController == null || !_isLocationLoaded) return;

    var jsonData = await readJsonData();

    for (var data in jsonData) {
      trashTongs.add(
        NMarker(
          id: '${data['연번']}_${data['세부위치']}',
          position: NLatLng(
            double.parse(data['위도']),
            double.parse(data['경도']),
          ),
          icon: const NOverlayImage.fromAssetImage(AppIcons.trash_tong),
          size: const NSize(30, 40),
        ),
      );
    }
    // 개별 마커 표시
    for (NMarker trashTong in trashTongs) {
      trashTong.setMinZoom(12);
      trashTong.setIsVisible(isSelectedTrashTong);
      _mapController!.addOverlay(trashTong);
      final onMarkerInfoWindow = NInfoWindow.onMarker(
        id: trashTong.info.id,
        text: trashTong.info.id.split('_')[1],
      );

      trashTong.setOnTapListener(
        (NMarker trashTong) async => {
          if (await trashTong.hasOpenInfoWindow())
            {onMarkerInfoWindow.close()}
          else
            {trashTong.openInfoWindow(onMarkerInfoWindow)}
        },
      );
    }
  }

  Future<NOverlayImage> createNOverlayImageFromNetwork(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List imageData = response.bodyBytes;
        return NOverlayImage.fromByteArray(imageData);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Error loading image: $e');
    }
  }

  void updateMarkers() {
    // 쓰레기통 마커 업데이트
    if (_currentZoom < 13 && trashTongs.length > 1) {
    } else {
      // 개별 마커 표시
      for (final trashTong in trashTongs) {
        trashTong.setIsVisible(isSelectedTrashTong);
      }
    }
  }

  void goMain() {
    context.pushReplacement('/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _isLocationLoaded
            ? Stack(children: [
                NaverMap(
                  onMapReady: (controller) async {
                    _mapController = controller; // 지도 컨트롤러 초기화

                    // 내 위치 표시 아이콘 설정
                    final mylocation = _mapController!.getLocationOverlay();
                    final myImage = await createNOverlayImageFromNetwork(
                        currentPet['image']);
                    mylocation.setIcon(
                      currentPet['active']
                          ? myImage
                          : const NOverlayImage.fromAssetImage(
                              AppIcons.intro_box),
                    );
                    mylocation.setIconSize(const NSize(50, 70));
                    mylocation.setCircleColor(Colors.transparent);

                    _mapController!
                        .setLocationTrackingMode(NLocationTrackingMode.face);

                    createTrashtongMarkers();
                  },
                  options: NaverMapViewOptions(
                      // minZoom: 13,
                      // maxZoom: 16,
                      scaleBarEnable: false,
                      logoAlign: NLogoAlign.leftTop,
                      logoMargin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      initialCameraPosition: NCameraPosition(
                          target: NLatLng(latitude, longitude),
                          zoom: 15,
                          bearing: 0,
                          tilt: 45)),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.75,
                  right: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                trashTongToggle();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.basicgray
                                                .withOpacity(0.2),
                                            blurRadius: 1,
                                            spreadRadius: 1)
                                      ]),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: Center(
                                      child: Image.asset(
                                    AppIcons.trash_tong,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: MediaQuery.of(context).size.height *
                                        0.05,
                                  ))),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                returnCurrentLocation();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.basicgray
                                              .withOpacity(0.2),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: const Center(
                                  child: Icon(Icons.my_location),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            '원정을 종료하시겠습니까?',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text('취소')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    var main = Provider.of<
                                                            MainProvider>(
                                                        context,
                                                        listen: false);
                                                    main.setIsTutorialPloggingFinish();
                                                    Navigator.of(context).pop();
                                                    goMain();
                                                  },
                                                  child: const Text('확인'))
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.basicgray
                                              .withOpacity(0.2),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Center(
                                  child: Text(
                                    '종 료',
                                    style: CustomFontStyle.getTextStyle(context,
                                        CustomFontStyle.yeonSung70_white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
