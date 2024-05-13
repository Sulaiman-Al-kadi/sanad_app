import 'package:flutter/material.dart';
import 'package:sanad_app/routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBNpuA5CzcH_djqjJ9vWoNtMGn6I0iudSE",
      appId: "1:489826002106:android:d15a451061bf6225df0e83",
      messagingSenderId: "489826002106",
      projectId: "sanaddb1",
      storageBucket: 'gs://sanaddb1.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: Login(),
      initialRoute: "/",
      routes: routes,
    );
  }
}
