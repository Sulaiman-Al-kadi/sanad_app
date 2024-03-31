import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Dashboard"), backgroundColor: Colors.blue),
      bottomNavigationBar: Nbar(),
    );
  }
}
