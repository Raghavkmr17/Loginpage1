import 'package:currency_converter/ForgotPasswordPage.dart';
import 'package:currency_converter/success_page.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Themi extends ConsumerStatefulWidget {
  const Themi({super.key});
  @override
  ConsumerState<Themi> createState() => Mystate();
}

class Mystate extends ConsumerState<Themi> {
  bool _visible = false;

  void _login() async {
    final email = ref.read(emailprovider);
    final password = ref.read(passwordprovider);
    final pref = await ref.read(spprovider.future);
    final storedemail = pref.getString('email');
    final storedpassword = pref.getString('password');
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorms = "Email or password cannot be empty";
      });
    } else if (email == storedemail && password == storedpassword) {
      setState(() {
        emailcontroller.clear();
        passwordcontroller.clear();
        ref.read(emailprovider.notifier).state = '';
        ref.read(passwordprovider.notifier).state = '';
        _errorms = '';
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Sucesspage()));
    } else {
      setState(() {
        _errorms = "Invalid email or password";
      });
    }
  }

  late TextEditingController emailcontroller;
  late TextEditingController passwordcontroller;
  late var _errorms;
  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    _errorms = '';
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void _forgotPassword() {
    setState(() {
      emailcontroller.clear();
      passwordcontroller.clear();
      ref.read(emailprovider.notifier).state = '';
      ref.read(passwordprovider.notifier).state = '';
      _errorms = '';
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Forgotpasswordpage()));
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
                    controller: emailcontroller,
                    onChanged: (value) =>
                        ref.read(emailprovider.notifier).state = value,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 58, 40, 34),
                      fontSize: 19,
                    ),
                    decoration: InputDecoration(
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
                    controller: passwordcontroller,
                    onChanged: (value) =>
                        ref.read(passwordprovider.notifier).state = value,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 58, 40, 34),
                      fontSize: 19,
                    ),
                    decoration: InputDecoration(
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
