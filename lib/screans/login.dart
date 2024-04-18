// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sanad_app/screans/forget_passwprd.dart';
// import 'package:sanad_app/screans/signup.dart';
// import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final _auth = FirebaseAuth.instance;

//   late String email;
//   late String password;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 100),
//               Image.asset(
//                 'images/login_icon.jpeg',
//                 width: 170,
//                 height: 170,
//               ),
//               const SizedBox(
//                 height: 70,
//               ),
//               TextField(
//                 onChanged: (value) {
//                   email = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Email',
//                   prefixIcon: const Icon(Icons.email),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 onChanged: (value) {
//                   password = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'password',
//                   prefixIcon: const Icon(Icons.password),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               MaterialButton(
//                 elevation: 5.0,
//                 color: const Color.fromARGB(255, 4, 131, 234),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
//                 // ignore: sort_child_properties_last
//                 child: const Text(
//                   'تسجيل الدخول',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 254, 254, 254),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 shape: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(50),
//                   borderSide: BorderSide.none,
//                 ),
//                 onPressed: () async {
//                   final user = await _auth.signInWithEmailAndPassword(
//                       email: email, password: password);

//                   try {
//                     if (user != null) {
//                       Navigator.of(context).pushNamed("/admin_homepage");
//                     }
//                   } catch (e) {
//                     print(e);
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () {
//                       Navigator.of(context).pushNamed("/forget_ password");

//                 },
//                 child: const Text(
//                   'نسيت كلمة المرور؟',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               GestureDetector(
//                 onTap: () {
//                       Navigator.of(context).pushNamed("/signup");

//                 },
//                 child: const Text(
//                   'إنشاء حساب جديد',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset(
                'images/login_icon.jpeg',
                width: 170,
                height: 170,
              ),
              SizedBox(height: 70),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              MaterialButton(
                elevation: 5.0,
                color: Color.fromARGB(255, 4, 131, 234),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                child: Text(
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
                          // Redirect user to user page
                          break;
                        case 'Manager':
                          Navigator.of(context)
                              .pushReplacementNamed("/mp_homepage");
                          // Redirect user to manager page
                          break;
                        case 'Maintenance Personnel':
                          Navigator.of(context)
                              .pushReplacementNamed("/mp_homepage");
                          // Redirect user to maintenance page
                          break;
                        default:
                          // Handle unknown user type
                          break;
                      }
                    }
                  } catch (e) {
                    print(e);
                    // Handle login error
                  }
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/forget_password");
                },
                child: Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/signup");
                },
                child: Text(
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
