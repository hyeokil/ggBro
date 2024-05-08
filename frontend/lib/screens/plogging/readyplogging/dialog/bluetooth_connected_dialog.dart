import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class BluetoothConnectedDialog extends StatefulWidget {
  const BluetoothConnectedDialog({super.key});

  @override
  State<BluetoothConnectedDialog> createState() => _BluetoothConnecState();
}

class _BluetoothConnecState extends State<BluetoothConnectedDialog> {
  List<ScanResult> scanResults = [];
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Bluetooth 목록'),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  children: scanResults
                      .map((r) => r.device.advName.isNotEmpty
                          ? ListTile(
                              title: Text(r.device.advName),
                              subtitle: Text(r.device.remoteId.toString()),
                              trailing: Text(r.device.isConnected
                                  ? 'Connected'
                                  : 'DisConnected'),
                              onTap: () {
                                connectToDevice(r.device);
                              })
                          : Container())
                      .toList(),
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('취소')),
                ElevatedButton(
                    onPressed: () => isScanning ? null : startScan(),
                    child: Text(isScanning ? '스캔 중' : '스캔 가능'))
              ],
            )
          ],
        ),
      ),
    );
  }

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

  void initBle() {
    // BLE 스캔 상태 얻기 위한 리스너
    FlutterBluePlus.isScanning.listen((isScan) {
      isScanning = isScan;
      setState(() {});
    });
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
      } // 블루투스 꺼져있다면 다시 켤 수 있도록
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
            print('${result.device.advName} found! rssi: ${result.rssi}');
          }
        }
      });
      FlutterBluePlus.cancelWhenScanComplete(subscription);
    } else {
      FlutterBluePlus.stopScan();
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
    } catch (e) {
      print('connect 에러 : $e');
    }
    if (device.isConnected) {
      Fluttertoast.showToast(msg: '${device.advName} 연결됨');
      print('연결됨: ${device.advName}');
    } else {
      Fluttertoast.showToast(msg: '연결실패');
    }
    // 연결된 기기로 추가 작업 수행
  }
}
