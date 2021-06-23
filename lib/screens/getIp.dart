import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:gateway/gateway.dart';

class IpPage extends StatefulWidget {
  const IpPage({Key? key}) : super(key: key);

  @override
  _IpPageState createState() => _IpPageState();
}

class _IpPageState extends State<IpPage> {
  String? ip;
  String? ipAddress;
  String? subnet;
  int port = 80;

  getIp() async {
    ip = await Wifi.ip;
    setState(() {
      ipAddress = ip;
    });
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
              onPressed: getIp,
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
