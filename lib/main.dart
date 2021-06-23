import 'package:flutter/material.dart';
import 'package:gateway/gateway.dart';
import 'package:test_app/screens/getIp.dart';
import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:test_app/wifiPage.dart';
import 'package:wifi/wifi.dart';

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
      //! icmp ping to host
      ping = Ping(
        'tanmoykarmakar.in', //!host name getting converted to ip
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
//  ip:192.168.29.1
//  localIP:192.168.29.85
//  netmask:255.255.255.0
//  broadcast:192.168.29.255

    Gateway gt = await Gateway.info;
    print(gt);
  }

  getNetworkDevices() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 80;

    final stream = NetworkAnalyzer.discover2(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
      }
    });
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WifiPage(),
                    )),
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
