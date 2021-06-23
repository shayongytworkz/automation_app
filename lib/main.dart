// @dart=2.9
import 'package:flutter/material.dart';
import 'package:gateway/gateway.dart';
import 'package:test_app/screens/getIp.dart';
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

  gateway() async {
    Gateway gt = await Gateway.info;
    print(gt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => IpPage()));
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'get Ip',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: startPing,
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Network Devices',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: gateway,
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Gateway',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: startPing,
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Click Me',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
