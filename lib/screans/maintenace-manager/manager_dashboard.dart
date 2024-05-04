import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class ManagerDashbaord extends StatelessWidget {
  const ManagerDashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbaord"),
      ),
      bottomNavigationBar: ManagerNBar(),
    );
  }
}
