import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/plogging/finishplogging/finish_plogging_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class ProgressMap extends StatefulWidget {
  const ProgressMap({super.key});

  @override
  State<ProgressMap> createState() => _ProgressMapState();
}

class _ProgressMapState extends State<ProgressMap> {
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
  double _currentZoom = 15.0; // 클러스터링 초기 줌 레벨 설정;

  @override
  void initState() {
    super.initState();
    totalDistance = 0;
    getLocation();
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
  getLocation() async {
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

  realTimePath() {
    // distanceFilter의 거리 이동 시 계속해서 위치를 받아옴
    pathStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(distanceFilter: 2))
        .listen((Position position) {
      print('경로 : $_pathPoints');
      setState(() {
        previousLatitude = _pathPoints.last.latitude;
        previousLongitude = _pathPoints.last.longitude;
        latitude = position.latitude;
        longitude = position.longitude;

        _pathPoints.add(NLatLng(latitude, longitude)); // 받아온 위치 추가하는 부분
        double distanceInMeters = Geolocator.distanceBetween(
            previousLatitude, previousLongitude, latitude, longitude);
        print(
            '경로 : $previousLatitude, $previousLongitude -> $latitude, $longitude, 거리 : $distanceInMeters');
        totalDistance += distanceInMeters; // 총거리에 더해주기
        print('총거리 : $totalDistance');
      });
      _mapController!.addOverlay(NPathOverlay(
        id: 'realtime',
        width: 5,
        coords: _pathPoints,
        color: AppColors.basicgreen,
      ));
    });
  } // 실시간으로 경로 받아오는 함수

  // 지도에서 다른 화면을 보다가 현재 위치로 돌아오는 함수
  void returnCurrentLocation() async {
    await getLocation();
    print('현재 위치로 $latitude랑 $longitude');
    _mapController!.updateCamera(
        NCameraUpdate.scrollAndZoomTo(target: NLatLng(latitude, longitude))
          ..setPivot(NPoint(1 / 2, 10 / 11)));
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

  void _onCameraIdle() {
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

  String _getClusterKey(Map<String, dynamic> data) {
    // 클러스터 키 생성 로직, 예: 위치를 기반으로 그리드 생성
    int gridLat = (double.parse(data['위도']) * 10).floor();
    int gridLng = (double.parse(data['경도']) * 10).floor();
    return "$gridLat:$gridLng";
  }

  void updateMarkers() async {
    if (_mapController == null || !_isLocationLoaded) return;
    await _mapController!.clearOverlays(type: NOverlayType.marker);

    var jsonData = await readJsonData();
    Map<String, List<NMarker>> clusters = {};

    if (isSelectedTrashTong) {
      for (var data in jsonData) {
        var key = _getClusterKey(data);
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
    // print("줌 $_currentZoom");
    if (_currentZoom < 13) {
      await _mapController!.clearOverlays();
    }
    // 클러스터 또는 개별 마커 표시
    clusters.forEach(
      (key, markers) {
        if (_currentZoom < 13 && markers.length > 1) {
          // 클러스터 표시
          _displayClusterMarker(markers);
        } else {
          // 개별 마커 표시
          for (final marker in markers) {
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

  void _displayClusterMarker(List<NMarker> markers) {
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
      size: const NSize(100, 100),
      caption: NOverlayCaption(text: '${markers.length}', textSize: 20),
    );
    _mapController!.addOverlay(clusterMarker);
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
                  _mapController!
                      .setLocationTrackingMode(NLocationTrackingMode.follow);
                  NCameraPosition(
                    target: NLatLng(latitude, longitude),
                    zoom: 15,
                  );
                  _mapController!.updateCamera(
                    NCameraUpdate.withParams(
                        target: NLatLng(latitude, longitude),
                        zoom: 15,
                        bearing: 0,
                        tilt: 45)
                      ..setPivot(const NPoint(1 / 2, 10 / 11)),
                  );
                  updateMarkers(); // 지도 준비 완료 후 마커 업데이트 호출
                },
                onCameraIdle: _onCameraIdle,
                options: const NaverMapViewOptions(
                  scaleBarEnable: false,
                  logoAlign: NLogoAlign.leftTop,
                  logoMargin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                ),
              ),
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
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.basicgray.withOpacity(0.2),
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ]),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '총 처치 현황',
                                      style: CustomFontStyle.getTextStyle(
                                        context,
                                        CustomFontStyle.yeonSung60,
                                      ),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      AppIcons.trash_tong,
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      '플라몽 처치 : 1',
                                      style: CustomFontStyle.getTextStyle(
                                        context,
                                        CustomFontStyle.yeonSung60,
                                      ),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '율몽 처치 : 1',
                                      style: CustomFontStyle.getTextStyle(
                                        context,
                                        CustomFontStyle.yeonSung60,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.basicgray.withOpacity(0.2),
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '플라몬 처치 + 1',
                                  style: CustomFontStyle.getTextStyle(
                                    context,
                                    CustomFontStyle.yeonSung60,
                                  ),
                                ),
                              ]),
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
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
                              child: Center(
                                  child: Image.asset(
                                AppIcons.trash_tong,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                              )),
                            ),
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
                                  return const FinishPloggingDialog();
                                },
                              ).then(
                                (value) => context.go('/main'),
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
