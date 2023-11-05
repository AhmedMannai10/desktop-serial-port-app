import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class IOPage extends StatefulWidget {
  final String passedPortName;
  const IOPage({super.key, required this.passedPortName});

  @override
  State<IOPage> createState() => _IOPageState();
}

class _IOPageState extends State<IOPage> {
  late String serialPortName;
  late SerialPort _serialPort;
  late SerialPortReader _serialPortReader;
  final TextEditingController _messageController = TextEditingController();
  String _chatText = "";
  late Stream<Uint8List> _serialDataStream;

  @override
  void initState() {
    super.initState();
    serialPortName = widget.passedPortName.replaceAll('-', '/');
    _initSerialPort();
    _serialDataStream = _listenForPort();
  }

  Stream<Uint8List> _listenForPort() async* {
    await for (Uint8List uint8List in _serialPortReader.stream) {
      String line = utf8.decode(uint8List);
      print('New line read: $line');

      yield Uint8List.fromList(
          uint8List); // You can yield the raw data if needed

      setState(() {
        _chatText += "Received: $line";
      });
    }
  }

  Future<void> _initSerialPort() async {
    _serialPort = SerialPort(serialPortName);
    _serialPort.openReadWrite();
    _serialPortReader = SerialPortReader(_serialPort);
  }

  Future<void> _sendMessage() async {
    String message = '${_messageController.text}\r\n';
    if (message.isNotEmpty) {
      int numberOfWritenBytes =
          _serialPort.write(Uint8List.fromList([...message.codeUnits, 10]));
      print('Writen Bytes: $numberOfWritenBytes');
      setState(() {
        _chatText += "Sent: $message";
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _serialPort.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Read && Write',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: const Color(0xfffe8019)),
      body: Column(
        children: <Widget>[
          StreamBuilder(
              stream: _serialDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data}');
                }
                return const Text("--");
              }),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _chatText,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white70),
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Enter your message",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
