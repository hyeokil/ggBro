import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
                            onTap: () => connectToDevice(r.device),
                          )
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
          print('${result.device.advName} found! rssi: ${result.advertisementData.serviceUuids}');
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

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              context.push('/ploggingProgress');
            },
            child: const Text("시작하러 가기")),
        const Text('스캔스크린'),
      ]),
    ),
  );
}
