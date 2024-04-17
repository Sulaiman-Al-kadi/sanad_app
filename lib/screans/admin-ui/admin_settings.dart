import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("الاعدادات"), backgroundColor: Colors.blue),
      bottomNavigationBar: const Nbar(),
    );
    ;
  }
}
