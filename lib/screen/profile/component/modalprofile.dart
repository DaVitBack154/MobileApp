import 'package:flutter/material.dart';

class ModalProfile extends StatefulWidget {
  const ModalProfile({super.key});

  @override
  State<ModalProfile> createState() => _ModalProfileState();
}

class _ModalProfileState extends State<ModalProfile> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      // height: _height,
      color: Colors.amber,
      child: Text('tokotadfdf'),
    );
  }
}
