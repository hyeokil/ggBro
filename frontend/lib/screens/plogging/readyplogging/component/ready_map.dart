import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:geolocator/geolocator.dart';

class ReadyMap extends StatefulWidget {
  const ReadyMap({super.key});

  @override
  State<ReadyMap> createState() => _ReadyMapState();
}

class _ReadyMapState extends State<ReadyMap> {
  late double latitude;
  late double longitude;
  bool _isLocationLoaded = false; // 위치 데이터 로드 상태를 추적하는 플래그
  NaverMapController? _mapController; // 지도 컨트롤러를 옵셔널로 선언
  bool isSelectedTrashTong = false;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _isLocationLoaded = true;
    });
    print('위치요 ${position.latitude}, ${position.longitude}');
  }

  Future<List<dynamic>> readJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/trash_tong_data.json');
    return jsonDecode(jsonString);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void trashTongToggle() {
    setState(() {
      isSelectedTrashTong = !isSelectedTrashTong;
    });
    // print(isSelectedTrashTong);
    updateMarkers();
  }

  String getClusterKey(double lat, double lng, double zoomLevel) {
    // 위치와 줌 레벨에 따라 클러스터 키 생성
    int latIndex = (lat * zoomLevel).floor();
    int lngIndex = (lng * zoomLevel).floor();
    return "$latIndex:$lngIndex";
  }

  NMarker createClusterMarker(List<NMarker> markers) {
    // 클러스터 마커 생성 로직
    // 예를 들어 클러스터의 중심점을 계산하거나, 마커 수를 표시 등
    double centerLat = 0;
    double centerLng = 0;
    for (var marker in markers) {
      centerLat += marker.position.latitude;
      centerLng += marker.position.longitude;
    }
    centerLat /= markers.length;
    centerLng /= markers.length;

    return NMarker(
      id: "cluster_${markers.first}",
      position: NLatLng(centerLat, centerLng),
      icon: NOverlayImage.fromAssetImage(AppIcons.trash_tong),
      size: NSize(50, 50),
    );
  }

  void updateMarkers() async {
    if (_mapController == null || !_isLocationLoaded) return;
    await _mapController!.clearOverlays();

    var jsonData = await readJsonData();
    Map<String, List<NMarker>> clusters = {};

    if (isSelectedTrashTong) {
      for (var data in jsonData) {
        String clusterKey = getClusterKey(data['위도'], data['경도'], 3);
        final marker = NMarker(
          id: data['연번'].toString(),
          position: NLatLng(
            double.parse(data['위도']),
            double.parse(data['경도']),
          ),
          icon: NOverlayImage.fromAssetImage(AppIcons.trash_tong),
          size: NSize(40, 50),
        );
        await _mapController!.addOverlay(marker);

        final onMarkerInfoWindow = NInfoWindow.onMarker(
          id: marker.info.id,
          text: '${data['세부위치']}',
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
      // 클러스터링된 마커 표시
      for (var cluster in clusters.values) {
        if (cluster.length > 1) {
          // 클러스터 대표 마커 생성
          NMarker clusterMarker = createClusterMarker(cluster);
          await _mapController!.addOverlay(clusterMarker);
        } else {
          // 단일 마커 표시
          await _mapController!.addOverlay(cluster[0]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.white),
      child: _isLocationLoaded
          ? Stack(
              children: [
                NaverMap(
                  onMapReady: (controller) {
                    _mapController = controller; // 지도 컨트롤러 초기화
                    _mapController!
                        .setLocationTrackingMode(NLocationTrackingMode.follow);
                    updateMarkers(); // 지도 준비 완료 후 마커 업데이트 호출
                  },
                  options: NaverMapViewOptions(
                    liteModeEnable: true,
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(latitude, longitude),
                      zoom: 15,
                      bearing: 0,
                      tilt: 0,
                    ),
                    locationButtonEnable: true,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: GestureDetector(
                    onTap: () {
                      trashTongToggle();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.basicgray.withOpacity(0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.004,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.09,
                              height: MediaQuery.of(context).size.height * 0.04,
                              // color: Colors.black,
                              child: Image.asset(AppIcons.trash_tong),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.width * 0.02,
                            child: Text(
                              '쓰레기통 위치 확인',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung60,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
