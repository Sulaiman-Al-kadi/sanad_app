import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Dashboard"), backgroundColor: Colors.blue),
      bottomNavigationBar: Nbar(),
    );
  }
}
