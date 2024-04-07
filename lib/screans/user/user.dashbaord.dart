import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbaord"),
      ),
      bottomNavigationBar: Nbar(),
    );
  }
}
