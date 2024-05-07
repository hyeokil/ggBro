import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<ScanResult> scanResults = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    bluetoothSetting();
    initBle();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('블루투스 기기 스캔'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () => isScanning ? null : startScan(),
            child: Text(isScanning ? '스캔 중...' : '스캔 시작'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/ploggingProgress');
            },
            child: const Text("플로깅 출발"),
          ),
          StreamBuilder<List<ScanResult>>(
            stream: FlutterBluePlus.onScanResults,
            initialData: const [],
            builder: (c, snapshot) => Container(
              color: Colors.yellow,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                children: snapshot.data!
                    .map((r) => r.device.advName.isNotEmpty
                        ? ListTile(
                            title: Text(r.device.advName),
                            subtitle: Text(r.device.readRssi().toString()),
                            trailing: Text(r.device.connectionState.toString()),
                            onTap: () {
                              connectToDevice(r.device);
                            })
                        : Container())
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bluetoothSetting() async {
    if (await FlutterBluePlus.isSupported == false) {
      Fluttertoast.showToast(msg: '블루투스가 지원되지 않습니다.');
      return;
    }

    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.on) {
        Fluttertoast.showToast(msg: '블루투스 켜져있음');
      } // 블루투스가 켜져있다면 스캔 시작
      else {
        if (Platform.isAndroid) {
          await FlutterBluePlus.turnOn();
          Fluttertoast.showToast(msg: '블루투스 연결됨');
        }
      } // 블루투스 꺼져있다면 다시 켜게
    });
  }

  void initBle() {
    // BLE 스캔 상태 얻기 위한 리스너
    FlutterBluePlus.isScanning.listen((isScan) {
      isScanning = isScan;
      setState(() {});
    });
  }

  void startScan() {
    if (!isScanning) {
      scanResults.clear(); // 스캔 중 아니라면 기존 스캔 목록 삭제

      FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 10)); // 새로운 스캔 시작

      var subscription = FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          scanResults = results;
        });
        for (ScanResult result in results) {
          if (result.device.advName.isNotEmpty) {
            print(
                '${result.device.advName} found! rssi: ${result.device.readRssi()}');
          }
        }
      });
      FlutterBluePlus.cancelWhenScanComplete(subscription);
    } else {
      FlutterBluePlus.stopScan();
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    Fluttertoast.showToast(msg: '${device.advName} 연결됨');
    print('연결됨: ${device.advName}');
    // 연결된 기기로 추가 작업 수행
  }
}
