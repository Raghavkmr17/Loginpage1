import 'package:currency_converter/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Newacc extends StatefulWidget {
  const Newacc({super.key});

  @override
  State<Newacc> createState() => _NewaccState();
}

class _NewaccState extends State<Newacc> {
  TextEditingController emails = TextEditingController();
  final passwords = TextEditingController();
  bool _visible = false;
  bool isSuccess = false;
  String errorms = "";
  bool validatemail() {
    final bool isValid = EmailValidator.validate(emails.text.trim());
    return isValid;
  }

  void _createAccount() async {
    if (emails.text.isEmpty || passwords.text.isEmpty) {
      setState(() {
        errorms = "Email and password cannot be empty";
      });
    } else if (!validatemail()) {
      setState(() {
        errorms = "Enter a valid email address";
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emails.text.trim());
      await prefs.setString('password', passwords.text.trim());
      setState(() {
        if (isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Firstpage()),
          );
        } else {
          errorms = "Enter a valid password";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 159, 254, 181),
          title: const Text(
            'Create a account',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/new.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/headerimg.jpg',
              fit: BoxFit.cover,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 200, left: 20, right: 20, bottom: 20),
                      child: TextField(
                        controller: emails,
                        style: const TextStyle(
                            fontSize: 19, color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: const InputDecoration(
                            hintText: "Enter the email id",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 247, 247)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 20),
                      child: TextField(
                        controller: passwords,
                        style: const TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 89, 63, 53)),
                        decoration: InputDecoration(
                          hintText: "Enter the password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 247, 247),
                          suffixIcon: IconButton(
                            icon: Icon(_visible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_visible,
                      ),
                    ),
                    if (errorms.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20),
                        child: Text(
                          errorms,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 16,
                              backgroundColor: Colors.white),
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    FlutterPwValidator(
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        width: 350,
                        height: 150,
                        minLength: 8,
                        onSuccess: () {
                          setState(() {
                            isSuccess = true;
                          });
                        },
                        controller: passwords),
                    TextButton(
                      onPressed: () {
                        _createAccount();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 21, 98, 160),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          )),
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
