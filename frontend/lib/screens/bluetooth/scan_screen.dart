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
  // FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    bluetoothSetting();
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
                            subtitle: Text(r.device.remoteId.toString()),
                            onTap: () {
                              connectToDevice(r.device);
                              Fluttertoast.showToast(msg: '${r.device} 연결됨');
                            })
                        : Container())
                    .toList(),
                // .map(
                //   (r) => ListTile(
                //     title: Text(r.device.advName),
                //     subtitle: Text(r.device.remoteId.toString()),
                //     onTap: () => connectToDevice(r.device),
                //   ),
                // )
                // .toList(),
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

    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        Fluttertoast.showToast(msg: '블루투스 켜져있음');
      } // 블루투스가 켜져있다면 스캔 시작
      else {
        if (Platform.isAndroid) {
          FlutterBluePlus.turnOn();
          Fluttertoast.showToast(msg: '블루투스 연결 안되있음');
        }
      } // 블루투스 꺼져있다면 다시 켜게
    });
  }

  List<ScanResult> scanResults = [];

  void startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10)).then(
      (value) => setState(() => isScanning = false),
    );

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
        isScanning = false;
      });
      for (ScanResult result in results) {
        if (result.device.advName.isNotEmpty) {
          print(
              '${result.device.advName} found! rssi: ${result.device.readRssi()}');
        }
      }
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    print('연결됨: ${device.advName}');
    // 연결된 기기로 추가 작업 수행
  }
}
