import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> availablePorts = <String>[];

  @override
  void initState() {
    super.initState();
    setState(() {
      availablePorts = SerialPort.availablePorts;
    });
  }

  void initPorts() {
    setState(() {
      availablePorts = SerialPort.availablePorts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Serial Port APP",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color(0xfffe8019)),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xfffe8019),
            child: const Icon(Icons.refresh_sharp),
            onPressed: () {
              initPorts();
            }),
        body: Scrollbar(
          // margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          // constraints: const BoxConstraints(maxWidth: 800, minWidth: 400),
          child: ListView(
            children: [
              for (final name in availablePorts)
                Builder(
                  builder: (context) {
                    final port = SerialPort(name);
                    return ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      selectedColor: Colors.white,
                      selectedTileColor: Colors.deepPurple,
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          // color: Colors.white54,
                        ),
                      ),
                      leading: const Icon(
                        Icons.settings_input_hdmi_sharp,
                        color: Colors.white,
                      ),
                      onTap: () {
                        String pathname = name.trim().replaceAll('/', '-');
                        print(pathname);
                        context.go('/port-details/$pathname');
                      },
                    );
                  },
                ),
            ],
          ),
        ));
  }
}
