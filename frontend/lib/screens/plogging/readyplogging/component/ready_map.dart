import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    getLocation();
  }


  @override
  Widget build(BuildContext context) {
    bool isSelectedTrashTong = false;

    void trashTongToggle() {
      isSelectedTrashTong != isSelectedTrashTong;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(color: Colors.white),
      child: _isLocationLoaded
          ? Stack(
              children: [
                NaverMap(
                  options: NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(latitude, longitude),
                      zoom: 15,
                      bearing: 0,
                      tilt: 0,
                    ),
                    locationButtonEnable: true,
                  ),
                  onMapReady: (controller) async {
                    // 지도 준비 완료 시 호출되는 콜백 함수
                    final marker1 = NMarker(
                        id: '1',
                        position: const NLatLng(35.1439276372, 126.8101870702));
                    marker1.setIcon(
                        NOverlayImage.fromAssetImage(AppIcons.trash_tong));
                    marker1.setSize(NSize(40, 50));

                    final marker2 = NMarker(
                        id: '2',
                        position: const NLatLng(35.1415385366, 126.7956927019));
                    marker2.setIcon(
                        NOverlayImage.fromAssetImage(AppIcons.trash_tong));
                    marker2.setSize(NSize(40, 50));

                    final onMarkerInfoWindow1 = NInfoWindow.onMarker(
                        id: marker1.info.id, text: "공항역 버스정류장");
                    marker1.openInfoWindow(onMarkerInfoWindow1);
                    final onMarkerInfoWindow2 = NInfoWindow.onMarker(
                        id: marker2.info.id, text: "송정KT 빌딩 앞 버스정류장");
                    marker2.openInfoWindow(onMarkerInfoWindow2);

                    if (isSelectedTrashTong = true) {
                      controller.addOverlayAll({marker1, marker2});
                    }
                  },
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
