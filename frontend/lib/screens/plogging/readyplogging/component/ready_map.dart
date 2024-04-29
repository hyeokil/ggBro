import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
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
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(color: Colors.white),
      child: _isLocationLoaded
          ? NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                    target: NLatLng(latitude, longitude),
                    zoom: 15,
                    bearing: 0,
                    tilt: 0),
              ),
              onMapReady: (controller) async {
                // 지도 준비 완료 시 호출되는 콜백 함수
                mapControllerCompleter
                    .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
                log("onMapReady", name: "onMapReady");
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
