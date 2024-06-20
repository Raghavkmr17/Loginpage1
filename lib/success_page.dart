import 'package:flutter/material.dart';

class Sucesspage extends StatelessWidget {
  const Sucesspage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SUCCESS"), centerTitle: true),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/login1.jpg',
            fit: BoxFit.cover,
          ),
          const Center(
            child: Text(
              "Your login successfull!!!",
              style: TextStyle(
                  backgroundColor: Colors.black,
                  fontSize: 34,
                  color: Color.fromARGB(255, 6, 242, 6),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
