import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:currency_converter/providers.dart';

class Forgotpasswordpage extends ConsumerStatefulWidget {
  @override
  _ForgotpasswordpageState createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends ConsumerState<Forgotpasswordpage> {
  final TextEditingController _oldpass = TextEditingController();
  final TextEditingController _newpass = TextEditingController();
  String _errorms = "";
  String _errorms1 = "";
  bool _vali = false;
  bool isSuccess = false;
  @override
  void dispose() {
    _oldpass.dispose();
    _newpass.dispose();
    super.dispose();
  }

  void _changePassword() async {
    final prefs = await ref.read(spprovider.future);
    final currentPass = prefs.getString('password');
    final newpassword = ref.read(newpasswordprovider);
    final oldpassword = ref.read(oldpasswordprovider);
    setState(() {
      if (oldpassword == currentPass) {
        if (newpassword.isNotEmpty) {
          if (isSuccess) {
            prefs.setString('password', newpassword);
            Navigator.pop(context);
          } else {
            _errorms1 = "Enter a valid password";
          }
        } else {
          _errorms1 = "Your new password cannot be empty";
        }
      } else {
        _errorms = "Enter the valid old password";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 225, 152),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 159, 254, 181),
          title: Text(
            'Create New Password',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
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
            SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 200, left: 20, right: 20, bottom: 20),
                      child: TextField(
                        controller: _oldpass,
                        onChanged: (value) => ref
                            .read(oldpasswordprovider.notifier)
                            .state = value,
                        style: TextStyle(
                            fontSize: 19, color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: InputDecoration(
                            hintText: "Enter old password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 247, 247)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 20),
                      child: TextField(
                        controller: _newpass,
                        onChanged: (value) => ref
                            .read(newpasswordprovider.notifier)
                            .state = value,
                        style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 89, 63, 53)),
                        decoration: InputDecoration(
                          hintText: "Enter new password",
                          errorText: _errorms1.isNotEmpty ? _errorms1 : null,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 247, 247),
                          suffixIcon: IconButton(
                            icon: Icon(_vali
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _vali = !_vali;
                              });
                            },
                          ),
                        ),
                        obscureText: !_vali,
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
                        onFail: () {
                          setState(() {
                            isSuccess = false;
                          });
                        },
                        controller: _newpass),
                    if (_errorms.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20),
                        child: Text(
                          _errorms,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _errorms = "";
                          _errorms1 = "";
                        });
                        _changePassword();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 21, 98, 160),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          )),
                      child: Text(
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
