import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

extension IntToString on int {
  String toHex() => '0x${toRadixString(16)}';
  String toPadded([int width = 3]) => toString().padLeft(width, '0');
  String toTransport() {
    switch (this) {
      case SerialPortTransport.usb:
        return 'USB';
      case SerialPortTransport.bluetooth:
        return 'Bluetooth';
      case SerialPortTransport.native:
        return 'Native';
      default:
        return 'Unknown';
    }
  }
}

class _ExampleAppState extends State<ExampleApp> {
  late SerialPort port;
  var availablePorts = [];

  @override
  void initState() {
    final arduinoPort = SerialPort.availablePorts.last;
    port = SerialPort(arduinoPort);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Serial Port example'),
        ),
        body: ListView(
          children: [
            CardListTile('Description', port.description),
            CardListTile('Transport', port.transport.toTransport()),
            CardListTile('USB Bus', port.busNumber?.toPadded()),
            CardListTile('USB Device', port.deviceNumber?.toPadded()),
            CardListTile('Vendor ID', port.vendorId?.toHex()),
            CardListTile('Product ID', port.productId?.toHex()),
            CardListTile('Manufacturer', port.manufacturer),
            CardListTile('Product Name', port.productName),
            CardListTile('Serial Number', port.serialNumber),
            CardListTile('MAC Address', port.macAddress),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              final isOpen = port.openReadWrite();
              if (isOpen) {
                final bytesWritten = port.write(Uint8List.fromList('tesddwdase'.codeUnits));
                log(bytesWritten.toString());
              }
            } catch (e) {
              log(e.toString());
            }
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  const CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}
