// @dart=2.9
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:gateway/gateway.dart';
import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String ip;
  String ipAddress;
  String subnet;
  int port = 80;

  Ping ping;

  startPing() async {
    try {
      ping = Ping(
        'google.com',
        count: 3,
        timeout: 1,
        interval: 1,
        ipv6: false,
      );
      ping.stream.listen((event) {
        print(event);
      });
    } catch (e) {
      print('error $e');
    }
  }

  getIp() async {
    ip = await Wifi.ip;
    Gateway gt = await Gateway.info;
    print(gt);
    // final stream = NetworkAnalyzer.discover2(subnet, port);
    // stream.listen((NetworkAddress addr) {
    //   if (addr.exists) {
    //     print('Found device: ${addr.ip}');
    //   }
    // });
    print(ip);
    setState(() {
      ipAddress = ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$ipAddress',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(onPressed: startPing, child: Text('Click Me'))
          ],
        ),
      ),
    );
  }
}
