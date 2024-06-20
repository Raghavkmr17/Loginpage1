import 'package:currency_converter/ForgotPasswordPage.dart';
import 'package:currency_converter/success_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themi extends StatefulWidget {
  const Themi({super.key});
  @override
  Mystate createState() => Mystate();
}

class Mystate extends State {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool validate = false;
  bool validates = false;
  String _errorms = '';
  bool _visible = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    setState(() {
      validate = _email.text.isEmpty;
      validates = _password.text.isEmpty;
      if (!validate && !validates) {
        if (_email.text == savedEmail && _password.text == savedPassword) {
          _errorms = "";
          _email.text = '';
          _password.text = '';
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Sucesspage()));
        } else {
          _errorms = "Invalid email or password";
          _visible = true;
        }
      }
    });
  }

  void _forgotPassword() {
    setState(() {
      _email.text = '';
      _password.text = '';
      _errorms = "";
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => Forgotpasswordpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: const Text(
          'KMRGRAM',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: _email,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 58, 40, 34),
                      fontSize: 19,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: validate ? "Value Can't Be Empty" : null,
                      hintText: 'Enter the user ID',
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      prefixIcon: const Icon(Icons.login),
                      //Colors(0xAARRGGBB)
                      prefixIconColor: const Color.fromARGB(174, 211, 0, 0),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 243, 248),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18, top: 7, right: 18, bottom: 5),
                  child: TextField(
                    controller: _password,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 58, 40, 34),
                      fontSize: 19,
                    ),
                    decoration: InputDecoration(
                      labelText: 'password',
                      errorText: validates ? "Value Can't Be Empty" : null,
                      hintText: 'Enter the password',
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      prefixIcon: const Icon(Icons.password),
                      //Colors(0xAARRGGBB)
                      prefixIconColor: const Color.fromARGB(174, 211, 0, 0),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 243, 248),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _visible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_visible,
                    cursorColor: Colors.black,
                  ),
                ),
                if (_errorms.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _errorms,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                TextButton(
                    onPressed: () {
                      _forgotPassword();
                    },
                    child: const Text(
                      "Change password ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextButton(
                    onPressed: () {
                      _login();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 22, 47, 130),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 251, 251),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
