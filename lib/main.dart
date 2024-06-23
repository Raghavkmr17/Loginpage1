import 'package:currency_converter/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: const Myapps(),
    ),
  );
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
