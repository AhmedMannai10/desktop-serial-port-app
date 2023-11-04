import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:go_router/go_router.dart';

class PortDetails extends StatelessWidget {
  final String portPassedName;
  const PortDetails({super.key, required this.portPassedName});

  @override
  Widget build(BuildContext context) {
    final String portName = portPassedName.replaceAll('-', '/');
    print('name of the port $portName');

    final SerialPort serialPort = SerialPort(portName);

    return Scaffold(
      appBar: AppBar(
        title: Text(portName),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white54),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ListView(
          children: [
            _informationField('Description', serialPort.description),
            _informationField('Transport', serialPort.transport.toString()),
            _informationField('USB Bus', serialPort.busNumber?.toString()),
            _informationField('USB Device', serialPort.deviceNumber.toString()),
            _informationField(
                'Vendor ID', serialPort.vendorId?.toRadixString(16)),
            _informationField(
                'Product ID', serialPort.productId?.toRadixString(16)),
            _informationField('Manufacturer', serialPort.manufacturer),
            _informationField('Product Name', serialPort.productName),
            _informationField('Serial Number', serialPort.serialNumber),
            _informationField('MAC Address', serialPort.macAddress),
          ],
        )),
      ),
    );
  }
}

Widget _informationField(String label, String? value) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    margin: EdgeInsets.only(top: 10),
    height: 50,
    decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Color(0xfffbf1c7)),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xfff9f1d7),
            )),
        Text(value ?? 'N/A',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xfffbf107),
            )),
      ],
    ),
  );
}
