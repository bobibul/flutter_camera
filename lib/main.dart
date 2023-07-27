import 'package:flutter/material.dart';
import 'camera_ex.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),

      home: CameraExample(),

    );

  }
}
