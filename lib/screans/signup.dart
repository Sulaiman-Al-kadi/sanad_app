// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sanad_app/screans/login.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final _auth = FirebaseAuth.instance;

//   late String email;
//   late String password;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("SettingsPage"), backgroundColor: Colors.blue),
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 50),
//               TextField(
//                 onChanged: (value) {
//                   email = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'البريد الالكتروني',
//                   prefixIcon: Icon(Icons.email),
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
//                   hintText: 'كلمة السر',
//                   prefixIcon: Icon(Icons.email),
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
//                 onChanged: (value) {},
//                 decoration: InputDecoration(
//                   hintText: 'تأكيد كلمة السر',
//                   prefixIcon: Icon(Icons.password),
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
//                 color: Color.fromARGB(255, 4, 131, 234),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
//                 // ignore: sort_child_properties_last
//                 child: const Text(
//                   'تسجيل حساب جديد',
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
//                   try {
//                     final newUser = await _auth.createUserWithEmailAndPassword(
//                         email: email, password: password);

//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return Login();
//                     }));
//                   } catch (e) {
//                     print(e);
//                   }
//                 },
//               ),
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

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String email;
  late String password;
  late String phoneNumber;
  late String firstName;
  late String lastName;
  late String userType = 'User'; // Initialize userType

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  textDirection: TextDirection.rtl,
                  "انشاء حساب جديد",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (value) {
                  firstName = value;
                },
                decoration: InputDecoration(
                  hintText: 'الاسم الاول',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                onChanged: (value) {
                  lastName = value;
                },
                decoration: InputDecoration(
                    hintText: 'اسم العائلة',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
              SizedBox(height: 24),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                  hintText: 'البريد الالكترني',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                  hintText: 'كلمة السر',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                onChanged: (value) {
                  phoneNumber = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                  hintText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: userType,
                onChanged: (value) {
                  setState(() {
                    userType = value!;
                  });
                },
                items: ['User', 'Admin', 'Manager', 'Maintenance Personnel']
                    .map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: InputDecoration(
                  label: Text("نوع المستخدم"),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.none)),
                ),
              ),
              SizedBox(height: 24),
              MaterialButton(
                onPressed: () async {
                  try {
                    final UserCredential newUserCredential =
                        await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    await _firestore
                        .collection('users')
                        .doc(newUserCredential.user!.uid)
                        .set({
                      'email': email,
                      'phoneNumber': phoneNumber,
                      'firstName': firstName,
                      'lastName': lastName,
                      'userType': userType,
                    });

                    Navigator.of(context)
                        .pop(); // Go back to previous screen after signup
                  } catch (e) {
                    print(e);
                    // Handle error here
                  }
                },
                elevation: 0.0,
                splashColor: Colors.blue,
                color: Color.fromARGB(255, 255, 255, 255),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 120),
                child: Text(
                  'تسجيل',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 21, 105, 173)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Divider(thickness: 1, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
