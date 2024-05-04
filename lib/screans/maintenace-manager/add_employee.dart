import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  String? _selectedUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, String> _maintenancePersonnel =
      {}; // Map to store document ID and email

  @override
  void initState() {
    super.initState();
    _fetchMaintenancePersonnel();
  }

  Future<void> _fetchMaintenancePersonnel() async {
    String t = 'null';
    final personnel = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Maintenance Personnel')
        .where('department', isEqualTo: t)
        .get();
    setState(() {
      _maintenancePersonnel = Map.fromIterable(
        personnel.docs,
        key: (doc) => doc.id,
        value: (doc) => doc['email'] as String,
      );
    });
  }

  Future<String?> _fetchManagerEmail() async {
    try {
      final managerQuerySnapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'Manager')
          .limit(1) // Limit to 1 document
          .get();

      if (managerQuerySnapshot.docs.isNotEmpty) {
        final managerDoc = managerQuerySnapshot.docs.first;
        return managerDoc['email'] as String?;
      }
    } catch (e) {
      print('Error fetching manager email: $e');
    }
    return null;
  }

  Future<String?> _fetchManagerDepartment(String managerEmail) async {
    try {
      final managerQuerySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: managerEmail)
          .limit(1) // Limit to 1 document
          .get();

      if (managerQuerySnapshot.docs.isNotEmpty) {
        final managerDoc = managerQuerySnapshot.docs.first;
        return managerDoc['department'] as String?;
      }
    } catch (e) {
      print('Error fetching manager department: $e');
    }
    return null;
  }

  void _addEmployee() async {
    if (_selectedUser == null) {
      _showAlert('Error: Please select a Maintenance Personnel');
      return;
    }

    try {
      final String? selectedUserId = _selectedUser;
      final managerEmail = await _fetchManagerEmail();
      final managerDepartment = await _fetchManagerDepartment(managerEmail!);

      if (managerDepartment != 'null') {
        // Check if manager's department is not 'null' before adding employee
        if (selectedUserId != null) {
          // Update the department of the selected Maintenance Personnel
          await _firestore.collection('users').doc(selectedUserId).update({
            'department': managerDepartment,
          });

          // Show success alert
          _showAlert(
              'Success: Maintenance Personnel department updated successfully');

          // Update dropdown list of Maintenance Personnel
          await _fetchMaintenancePersonnel();
        } else {
          _showAlert('Error: Maintenance Personnel not found');
        }
      } else {
        _showAlert(
            'Error: Manager\'s department is null. Please contact your administrator.');
      }
    } catch (e) {
      print('Error updating department: $e');
      _showAlert('Error: Failed to update Maintenance Personnel department');
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
              child: Text('OK'),
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
        title: Text('Add Employee'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedUser,
              hint: Text('Select Maintenance Personnel'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUser = newValue;
                });
              },
              items: _maintenancePersonnel.values
                  .map<DropdownMenuItem<String>>((String value) {
                final id = _maintenancePersonnel.keys.firstWhere(
                  (key) => _maintenancePersonnel[key] == value,
                );
                return DropdownMenuItem<String>(
                  value: id,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addEmployee,
              child: Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
