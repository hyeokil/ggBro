import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String base64String = '';
  List<ScanResult> scanResults = [];
  late BluetoothCharacteristic _notifyChar;
  late BluetoothDevice connectDevice;
  late StreamSubscription<List<int>> subscription;
  bool isScanning = false;
  bool isDisconnect = false;

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
      body: SingleChildScrollView(
        child: Column(
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
            ElevatedButton(
              onPressed: () {
                cancelDisconnected();
              },
              child: const Text("연결해제"),
            ),
            Container(
              color: Colors.yellow,
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
            base64String.isNotEmpty
                //     ? Text('문자열 길이 : ${base64String.length}')
                ? Image.memory(base64.decode(base64String))
                : Text('문자열 길이 : ${base64String.length}')
          ],
        ),
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
      findServiceAndCharacteristics(device);
    } else {
      Fluttertoast.showToast(msg: '연결실패');
    }
    // 연결된 기기로 추가 작업 수행
  }

  void cancelDisconnected() {
    print('연결 취소, $connectDevice, $subscription');
    if (FlutterBluePlus.connectedDevices.isNotEmpty) {
      connectDevice.disconnect();
      connectDevice.cancelWhenDisconnected(subscription);
    }
    setState(() {});
  }

  String bytesToHex(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  Set<String> imageResult = {};

  void findServiceAndCharacteristics(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid == Guid('6E400001-B5A3-F393-E0A9-E50E24DCCA9E')) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid ==
              Guid('6E400003-B5A3-F393-E0A9-E50E24DCCA9E')) {
            _notifyChar = characteristic;
            await _notifyChar.setNotifyValue(true);

            subscription = _notifyChar.onValueReceived.listen((event) {
              // print('Received: $event');
              if (String.fromCharCodes(event) == '0') {
                if (imageResult.isNotEmpty) {
                  base64String = imageResult.join(''); // 블루투스로 받아오는 데이터
                  imageResult.clear();
                  setState(() {});
                }
                return;
              }
              var result = '';
              event.toList().forEach((element) {
                result += String.fromCharCode(element);
              });
              print('결과물 : $result, 길이 ${result.length}');
              imageResult.add(result.split('|')[1]);
            });
            connectDevice = device;

            setState(() {});
          }
        }
      }
    }
  }
}
