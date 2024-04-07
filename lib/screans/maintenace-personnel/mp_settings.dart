import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class MPSettigns extends StatelessWidget {
  const MPSettigns({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("فني الصيانة اعدادت")),
      bottomNavigationBar: Nbar(),
    );
  }
}
