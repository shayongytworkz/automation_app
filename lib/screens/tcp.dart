import 'dart:io';

import 'package:flutter/material.dart';

class Tcp extends StatefulWidget {
  const Tcp({Key key}) : super(key: key);

  @override
  _TcpState createState() => _TcpState();
}

class _TcpState extends State<Tcp> {
  socket() async {
    Socket sock = await Socket.connect('192.168.1.129', 10000);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
