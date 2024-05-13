
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
  

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.1),
              const CircleAvatar(
                backgroundImage: AssetImage("images/image.png"),
                radius: 100,
                backgroundColor: Color.fromARGB(255, 255, 253, 253),
              ),
              SizedBox(height: screenHeight * 0.05),
              TextField(
               
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'البريد الالكتروني',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                 obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'كلمة السر',
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/forget_ password");
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style:
                          TextStyle(color: Color.fromARGB(255, 21, 105, 173)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              MaterialButton(
                elevation: 0.0,
                splashColor: Colors.blue,
                color: Color.fromARGB(255, 255, 255, 255),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: screenWidth * 0.24),
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 21, 105, 173)),
                ),
                onPressed: () async {
                  try {
                    final userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (userCredential.user != null) {
                      final userDoc = await _firestore
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .get();
                      final userType = userDoc['userType'];

                      // Navigate to appropriate page based on user type
                      switch (userType) {
                        case 'Admin':
                          Navigator.of(context)
                              .pushReplacementNamed("/admin_homepage");
                          break;
                        case 'User':
                          Navigator.of(context)
                              .pushReplacementNamed("/user_homepage");
                          break;
                        case 'Manager':
                          Navigator.of(context)
                              .pushReplacementNamed("/manager_homepage");
                          break;
                        case 'Maintenance Personnel':
                          Navigator.of(context)
                              .pushReplacementNamed("/mp_homepage");
                          break;
                        default:
                          break;
                      }
                    }
                  } catch (e) {
                    print(e);
                    // Handle login error
                  }
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Divider(),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'ليس لديك حساب؟',
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/signup");
                    },
                    child: const Text(
                      'انشاء حساب جديد',
                      style: TextStyle(
                        color: Color.fromARGB(255, 21, 105, 173),
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
