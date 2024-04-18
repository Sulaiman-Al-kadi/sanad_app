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
      appBar: AppBar(
        title: const Text("Signup Page"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                hintText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                firstName = value;
              },
              decoration: InputDecoration(
                hintText: 'First Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                lastName = value;
              },
              decoration: InputDecoration(
                hintText: 'Last Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
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
                hintText: 'User Type',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
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
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
