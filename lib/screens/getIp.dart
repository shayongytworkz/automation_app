import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:dart_ping/dart_ping.dart';

class IpPage extends StatefulWidget {
  const IpPage({Key key}) : super(key: key);

  @override
  _IpPageState createState() => _IpPageState();
}

class _IpPageState extends State<IpPage> {
  String ip;
  String ipAddress;
  String subnet;
  int port = 80;

  getIp() async {
    ip = await Wifi.ip;
    setState(() {
      ipAddress = ip;
    });
  }

  ping() {
    // Socket.connect(IPADDR, PORT, timeout: Duration(seconds: 5)).then((socket) {
    //   print("Success");
    //   socket.destroy();
    // }).catchError((error) {
    //   print("Exception on Socket " + error.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Address'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$ipAddress'),
            TextButton(
              onPressed: ping,
              child: Text(
                'getIp',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
