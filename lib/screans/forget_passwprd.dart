import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('نسيت كلمة المرور'),
        backgroundColor: Color.fromARGB(255, 21, 105, 173),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.1),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'البريد الإلكتروني',
                  label: Text('ادخل البريد الالكتروني'),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              MaterialButton(
                elevation: 0.0,
                splashColor: Color.fromARGB(255, 80, 133, 173),
                color: Color.fromARGB(255, 242, 243, 244),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: screenWidth * 0.15),
                child: Text(
                  'إعادة تعيين كلمة المرور',
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
                  if (_emailController.text.isEmpty) {
                    setState(() {
                      _message = "الرجاء إدخال بريد إلكتروني";
                    });
                    return;
                  }
                  await _resetPassword(_emailController.text);
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                _message,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      setState(() {
        _message = "تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني";
      });
    } catch (e) {
      setState(() {
        _message = "حدث خطأ. الرجاء المحاولة مرة أخرى.";
      });
      print(e);
    }
  }
}
