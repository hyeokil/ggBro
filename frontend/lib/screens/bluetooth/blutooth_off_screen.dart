import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothOffScreen extends StatefulWidget {
  const BluetoothOffScreen({super.key, required BluetoothAdapterState adapterState});

  @override
  State<BluetoothOffScreen> createState() => _BluetoothOffScreenState();
}

class _BluetoothOffScreenState extends State<BluetoothOffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('오프스크린'),
    );
  }
}
