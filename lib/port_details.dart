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
        backgroundColor: const Color(0xfffe8019),
        title: Text(
          portName,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black87),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          SizedBox(
            width: 200,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                String name = portName.trim().replaceAll('/', '-');
                context.go('/io-port/$name');
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.red)))),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_sharp,
                    color: Colors.black87,
                  ),
                  Text(" IO Port "),
                ],
              ),
            ),
          ),
        ],
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
    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    margin: const EdgeInsets.only(top: 10),
    height: 50,
    decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: const Color(0xfffbf1c7)),
        borderRadius: const BorderRadius.all(Radius.circular(8))),
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
