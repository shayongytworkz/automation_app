import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multicast_dns/multicast_dns.dart';

class Mdns extends StatefulWidget {
  const Mdns({Key key}) : super(key: key);

  @override
  _MdnsState createState() => _MdnsState();
}

class _MdnsState extends State<Mdns> {
  mdns() async {
    // var factory =
    //     (dynamic host, int port, {bool reuseAddress, bool reusePort, int ttl}) {
    //   return RawDatagramSocket.bind(host, port,
    //       reuseAddress: true, reusePort: false, ttl: 1);
    // };
    var client = MDnsClient();
    // Parse the command line arguments.

    const String name = '_dartobservatory._tcp.local';
    // Start the client with default options.
    await client.start();

    // Get the PTR record for the service.
    await for (final PtrResourceRecord ptr in client
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      // Use the domainName from the PTR record to get the SRV record,
      // which will have the port and local hostname.
      // Note that duplicate messages may come through, especially if any
      // other mDNS queries are running elsewhere on the machine.
      await for (final SrvResourceRecord srv
          in client.lookup<SrvResourceRecord>(
              ResourceRecordQuery.service(ptr.domainName))) {
        // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
        final String bundleId =
            ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
        print('Dart observatory instance found at '
            '${srv.target}:${srv.port} for "$bundleId".');
      }
    }
    client.stop();

    print('Done.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MDNS'),
      ),
      body: Center(
        child: TextButton(
          onPressed: mdns,
          child: Text('Get devices'),
        ),
      ),
    );
  }
}
