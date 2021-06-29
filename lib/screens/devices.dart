import 'package:flutter/material.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:wifi/wifi.dart';

class Devices extends StatefulWidget {
  const Devices({Key key}) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  getDevices(int fromPort, int toPort) async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    if (fromPort > toPort) {
      return;
    }

    print('port $fromPort');

    final stream = NetworkAnalyzer.discover2(subnet, fromPort);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}:$fromPort');
      }
    }).onDone(() {
      getDevices(fromPort + 1, toPort);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                getDevices(440, 446);
              },
              child: Text('Click Me')),
        ],
      ),
    );
  }
}
