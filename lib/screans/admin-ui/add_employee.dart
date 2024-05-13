import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEmplyee extends StatefulWidget {
  const AddEmplyee({Key? key}) : super(key: key);

  @override
  _AddEmplyeeState createState() => _AddEmplyeeState();
}

class _AddEmplyeeState extends State<AddEmplyee> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedManager;
  String? _selectedDepartment;
  List<String> _managers = [];
  List<String> _departments = [];

  @override
  void initState() {
    super.initState();
    _fetchManagers();
    _fetchDepartments();
  }

  Future<void> _fetchManagers() async {
    final managers = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Manager')
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['email'] as String).toList();
    });
    setState(() {
      _managers = managers;
    });
  }

  Future<void> _fetchDepartments() async {
    final departments = await FirebaseFirestore.instance
        .collection('department')
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
    setState(() {
      _departments = departments;
    });
  }

  void _updateDepartment() async {
    if (_selectedManager == null || _selectedDepartment == null) {
      _showAlert('Error: Please select a manager and department');
      return;
    }

    try {
      final managerDoc = await _firestore
          .collection('users')
          .where('email', isEqualTo: _selectedManager)
          .limit(1)
          .get();
      final managerId = managerDoc.docs.first.id;

      await _firestore.collection('users').doc(managerId).update({
        'department': _selectedDepartment,
      });

      _showAlert('نجحت عملية تحديث القسم بنجاح');
    } catch (e) {
      print('Error updating department: $e');
      _showAlert('خطأ: لم يتم تحديث القسم ');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.startsWith('Error') ? 'Error' : 'Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('اغلاق'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('تعيين مدير')),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton<String>(
                value: _selectedManager,
                hint: Text('اختر المدير المراد تعيينه'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedManager = newValue;
                  });
                },
                items: _managers.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: _selectedDepartment,
                hint: Text('اختر القسم'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDepartment = newValue;
                  });
                },
                items:
                    _departments.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateDepartment,
                child: Text('تحديث القسم'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
