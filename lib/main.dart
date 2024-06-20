import 'package:currency_converter/firstpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Myapps());
}

class Myapps extends StatelessWidget {
  const Myapps({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Firstpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
