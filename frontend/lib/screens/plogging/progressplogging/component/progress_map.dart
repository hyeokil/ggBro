import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/plogging/finishplogging/finish_plogging_dialog.dart';
import 'package:frontend/screens/plogging/progressplogging/component/finishcheck_plogging.dart';
import 'package:frontend/screens/plogging/progressplogging/component/total_trash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProgressMap extends StatefulWidget {
  const ProgressMap({
    super.key,
  });

  @override
  State<ProgressMap> createState() => _ProgressMapState();
}

class _ProgressMapState extends State<ProgressMap> {
  late MainProvider mainProvider;
  late UserProvider userProvider;

  late BluetoothDevice device;
  late double latitude;
  late double longitude; // 현재 위치 위도 경도를 업데이트 해 줄 변수
  double previousLatitude = 0;
  double previousLongitude = 0; // 직전 위도 경도 변수
  final List<NLatLng> _pathPoints = []; // 실시간 경로를 저장할 변수
  late StreamSubscription<Position> pathStream; // 실시간 경로 받아오는 stream 객체 변수
  late double totalDistance;
  bool isTrashTotal = false; // 쓰레기 현황 보여줄지 현재 주운 쓰레기 보여 줄지 체크
  bool _isLocationLoaded = false; // 위치 데이터 로드 상태를 추적하는 플래그
  NaverMapController? _mapController; // 지도 컨트롤러를 옵셔널로 선언
  bool isSelectedTrashTong = false;
  double _currentZoom = 15.0; // 클러스터링 초기 줌 레벨 설정

  // 블루투스용 변수들
  late double trashLatitude, trashLongitude; // 현재 위치 위도 경도를 업데이트 해 줄 변수
  late BluetoothCharacteristic _notifyChar;
  late StreamSubscription<List<int>> blueSubscription;
  int trashId = 0;
  List<int> imageResult = []; // 블루투스로 데이터 받을 때 저장 변수
  // String base64String = '';

  // api 응답 관련 변수
  late PloggingModel ploggingModel;
  late int ploggingId;
  late String accessToken, displayMonster;
  bool isKill = false;
  int plastic = 0, can = 0, glass = 0, normal = 0;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    ploggingModel = Provider.of<PloggingModel>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    startAPI();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    device = mainProvider.getDevice();
    findServiceAndCharacteristics();
    totalDistance = 0;
    getPathLocation();
    realTimePath();
  }

  // 위젯 제거 될 때 controller 제거, Stream 구독 취소
  @override
  void dispose() {
    pathStream.cancel();
    device.disconnect();
    _mapController!.dispose();
    super.dispose();
  }

  void startAPI() async {
    await ploggingModel.ploggingStart(accessToken, -1);
    ploggingId = ploggingModel.getPloggingId();
  }

  // 기기 서비스와 해당 서비스의 필요한 characteristic 연결 함수
  void findServiceAndCharacteristics() async {
    if (!device.isConnected) {
      // showDialog(
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (BuildContext context) {
      //       return const BluetoothConnectedDialog();
      //     });
    }
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid == Guid('6E400001-B5A3-F393-E0A9-E50E24DCCA9E')) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid ==
              Guid('6E400003-B5A3-F393-E0A9-E50E24DCCA9E')) {
            _notifyChar = characteristic;
            await _notifyChar.setNotifyValue(true);
            blueSubscription = _notifyChar.onValueReceived.listen((event) {
              // print('Received: ${event.length}');

              // 블루투스 연결 시 0 으로 데이터가 계속 넘어옴 0일 경우 return
              // 0이면서 쓰레기 데이터가 비어있지 않다면 데이터 합쳐서 쓰레기 줍기 api 요청
              if (String.fromCharCodes(event) == '0') {
                if (imageResult.isNotEmpty) {
                  // base64String = base64Encode(imageResult); base64 encode해서 보낼 경우 사용
                  // 쓰레기 판별 API
                  String monsterIcon = '';
                  ploggingModel.classificationTrash(
                      accessToken, trashLatitude, trashLongitude, imageResult);
                  imageResult.clear();
                  Map<String, dynamic> classificationData =
                      ploggingModel.getClassificationData();
                  switch (classificationData['trash_type']) {
                    case 'NORMAL':
                      normal += 1;
                      displayMonster = '미쪼몽';
                      monsterIcon = AppIcons.mizzomon;
                      break;
                    case 'CAN':
                      can += 1;
                      displayMonster = '포캔몽';
                      monsterIcon = AppIcons.pocanmong;
                      break;
                    case 'PLASTIC':
                      plastic += 1;
                      displayMonster = '플라몽';
                      monsterIcon = AppIcons.plamong;
                      break;
                    case 'GLASS':
                      glass += 1;
                      displayMonster = '율몽';
                      monsterIcon = AppIcons.yulmong;
                      break;
                    default:
                      return; // 판별하지 못했다면 마커 찍지 X
                  }
                  isKill = true;
                  Future.delayed(Duration(seconds: 3), () {
                    isKill = false;
                    setState(() {});
                  });
                  trashId += 1;
                  NMarker trashMarker = NMarker(
                    angle: 30,
                    id: 'trash$trashId',
                    position: NLatLng(trashLatitude, trashLongitude),
                    icon: NOverlayImage.fromAssetImage(monsterIcon),
                    size: const NSize(30, 40),
                  );
                  trashMarker.setGlobalZIndex(trashId);
                  _mapController!.addOverlay(trashMarker);
                  setState(() {});
                }
                return;
              }
              // 데이터 수신 시작했으므로 위치 저장
              if (imageResult.isEmpty) {
                getTrashLocation();
              }
              // '|' 뒤 데이터 저장
              List<int> result = [];
              for (int i = 0; i < event.length; i++) {
                if (String.fromCharCode(event[i]) == '|') {
                  result = event.sublist(i + 1);
                  break;
                }
              }
              imageResult.addAll(result);

              print('결과물 길이 ${result.length}');
            });
            device.cancelWhenDisconnected(blueSubscription);
          }
        }
      }
    }
  }

  getTrashLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      trashLatitude = position.latitude;
      trashLongitude = position.longitude;
    });
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
            locationSettings: const LocationSettings(distanceFilter: 10))
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

  void onCameraIdle() {
    if (_mapController == null) return;

    _mapController!.getCameraPosition().then((position) {
      // 유의미한 변화 확인
      if ((position.target.latitude - latitude).abs() > 0.0001 ||
          (position.target.longitude - longitude).abs() > 0.0001 ||
          (position.zoom - _currentZoom).abs() > 0.5) {
        setState(() {
          latitude = position.target.latitude;
          longitude = position.target.longitude;
          _currentZoom = position.zoom;
        });
        updateMarkers(); // 마커 업데이트
      }
    });
  }

  String getClusterKey(Map<String, dynamic> data) {
    // 클러스터 키 생성 로직, 예: 위치를 기반으로 그리드 생성
    int gridLat = (double.parse(data['위도']) * 10).floor();
    int gridLng = (double.parse(data['경도']) * 10).floor();
    return "$gridLat:$gridLng";
  }

  void updateMarkers() async {
    if (_mapController == null || !_isLocationLoaded) return;

    var jsonData = await readJsonData();
    Map<String, List<NMarker>> clusters = {};

    if (isSelectedTrashTong) {
      for (var data in jsonData) {
        var key = getClusterKey(data);
        if (!clusters.containsKey(key)) {
          clusters[key] = [];
        }
        clusters[key]!.add(
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
    }
    // 클러스터 또는 개별 마커 표시
    clusters.forEach(
      (key, markers) {
        if (_currentZoom < 13 && markers.length > 1) {
          // 클러스터 표시
          displayClusterMarker(markers);
        } else {
          // 개별 마커 표시
          for (final marker in markers) {
            marker.setMinZoom(13);
            _mapController!.addOverlay(marker);
            final onMarkerInfoWindow = NInfoWindow.onMarker(
              id: marker.info.id,
              text: marker.info.id.split('_')[1],
            );

            marker.setOnTapListener(
              (NMarker marker) async => {
                if (await marker.hasOpenInfoWindow())
                  {onMarkerInfoWindow.close()}
                else
                  {marker.openInfoWindow(onMarkerInfoWindow)}
              },
            );
          }
        }
      },
    );
  }

  void displayClusterMarker(List<NMarker> markers) {
    // 클러스터 대표 마커 표시
    var centerLat = 0.0;
    var centerLng = 0.0;
    for (var marker in markers) {
      centerLat += marker.position.latitude;
      centerLng += marker.position.longitude;
    }
    centerLat /= markers.length;
    centerLng /= markers.length;

    NMarker clusterMarker = NMarker(
      id: "cluster_${markers[0].info.id}",
      position: NLatLng(centerLat, centerLng),
      icon: const NOverlayImage.fromAssetImage(AppIcons.trash_tong),
      // 클러스터 아이콘 설정
      size: const NSize(90, 90),
      caption: NOverlayCaption(text: '${markers.length}', textSize: 20),
    );
    clusterMarker.setMaxZoom(13);
    _mapController!.addOverlay(clusterMarker);
  }

  void showFinishPloggingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const FinishPloggingDialog();
      },
    ).then((value) => context.pushReplacement('/main'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _isLocationLoaded
          ? Stack(children: [
              NaverMap(
                onMapReady: (controller) {
                  _mapController = controller; // 지도 컨트롤러 초기화

                  // 내 위치 표시 아이콘 설정
                  final mylocation = _mapController!.getLocationOverlay();
                  mylocation.setIcon(
                    const NOverlayImage.fromAssetImage(AppIcons.meka_sudal),
                  );
                  mylocation.setIconSize(const NSize(50, 50));
                  mylocation.setCircleColor(Colors.transparent);

                  _mapController!
                      .setLocationTrackingMode(NLocationTrackingMode.face);
                  updateMarkers(); // 지도 준비 완료 후 마커 업데이트 호출
                },
                onCameraIdle: onCameraIdle,
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
              // 이미지 확인용 코드
              // Positioned(
              //     child: base64String.isEmpty
              //         ? Image.asset(
              //             AppIcons.trash_tong,
              //             height: MediaQuery.of(context).size.height * 0.05,
              //             width: MediaQuery.of(context).size.height * 0.05,
              //           )
              //         : Image.memory(base64.decode(base64String))),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isTrashTotal = !isTrashTotal;
                    });
                  },
                  child: isTrashTotal
                      ? TotalTrash(
                          plastic: plastic,
                          can: can,
                          glass: glass,
                          normal: normal,
                        )
                      : isKill
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.37,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.basicgray
                                            .withOpacity(0.2),
                                        blurRadius: 1,
                                        spreadRadius: 1)
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '$displayMonster + 1',
                                      style: CustomFontStyle.getTextStyle(
                                        context,
                                        CustomFontStyle.yeonSung60,
                                      ),
                                    ),
                                  ]),
                            )
                          : Container(
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
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
                              child: const Center(
                                child: Icon(Icons.my_location),
                              ),
                            ),
                ),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
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
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
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
                                  return FinishCheckPloggingDialog(
                                    onConfirm: showFinishPloggingDialog,
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
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
                              child: const Center(
                                child: Icon(Icons.close),
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
    );
  }
}
