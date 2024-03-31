import 'package:flutter/material.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              Image.asset(
                'images/login_icon.jpeg',
                width: 170,
                height: 170,
              ),
              const SizedBox(
                height: 70,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'password',
                  prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                elevation: 5.0,
                color: Color.fromARGB(255, 4, 131, 234),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                // ignore: sort_child_properties_last
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Color.fromARGB(255, 254, 254, 254),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const Password();
                  }));
                },
                child: const Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const Signup();
                  }));
                },
                child: const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
