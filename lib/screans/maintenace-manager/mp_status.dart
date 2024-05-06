import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerMaintenancePersonnelPage extends StatefulWidget {
  const ManagerMaintenancePersonnelPage({Key? key}) : super(key: key);

  @override
  _ManagerMaintenancePersonnelPageState createState() =>
      _ManagerMaintenancePersonnelPageState();
}

class _ManagerMaintenancePersonnelPageState
    extends State<ManagerMaintenancePersonnelPage> {
  String? _selectedPersonnel;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _maintenancePersonnel = [];
  String? _managerDepartment;
  Map<String, dynamic>? _personnelInfo;

  @override
  void initState() {
    super.initState();
    _fetchManagerDepartment();
    _fetchMaintenancePersonnel();
  }

  Future<void> _fetchMaintenancePersonnel() async {
    final personnel = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Maintenance Personnel')
        .where('department', isEqualTo: _managerDepartment)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['email'] as String).toList();
    });
    setState(() {
      _maintenancePersonnel = personnel;
    });
  }

  Future<void> _fetchManagerDepartment() async {
    try {
      final managerEmail = await _fetchManagerEmail();
      if (managerEmail != null) {
        final managerDoc = await _firestore
            .collection('users')
            .where('email', isEqualTo: managerEmail)
            .limit(1)
            .get();
        if (managerDoc.docs.isNotEmpty) {
          final department = managerDoc.docs.first['department'] as String?;
          setState(() {
            _managerDepartment = department;
          });
        }
      }
    } catch (e) {
      print('Error fetching manager department: $e');
    }
  }

  Future<String?> _fetchManagerEmail() async {
    try {
      final managerQuerySnapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'Manager')
          .limit(1)
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

  Future<void> _fetchPersonnelInfo(String email) async {
    try {
      final personnelQuerySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (personnelQuerySnapshot.docs.isNotEmpty) {
        final personnelDoc = personnelQuerySnapshot.docs.first;
        setState(() {
          _personnelInfo = personnelDoc.data();
        });
      }
    } catch (e) {
      print('Error fetching personnel info: $e');
    }
  }

  Future<void> _changeAvailability(bool available) async {
    if (_selectedPersonnel == null) {
      _showAlert('Error: Please select a Maintenance Personnel');
      return;
    }

    try {
      final personnelQuerySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: _selectedPersonnel)
          .limit(1)
          .get();

      if (personnelQuerySnapshot.docs.isNotEmpty) {
        final personnelDoc = personnelQuerySnapshot.docs.first;
        await personnelDoc.reference.update({
          'available': available,
        });

        // Update _personnelInfo to reflect the updated availability
        await _fetchPersonnelInfo(_selectedPersonnel!);

        _showAlert('Success: Availability updated successfully');
      } else {
        _showAlert('Error: Maintenance Personnel document not found');
      }
    } catch (e, stackTrace) {
      print('Error updating availability: $e');
      print('Stack Trace: $stackTrace');
      _showAlert('Error: Failed to update availability');
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
        title: Text('Manager Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedPersonnel,
              hint: Text('Select Maintenance Personnel'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPersonnel = newValue;
                  _fetchPersonnelInfo(newValue!);
                });
              },
              items: _maintenancePersonnel
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            if (_personnelInfo != null) ...[
              Text(
                'Personnel Information:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                  'Name: ${_personnelInfo!['firstName']}  ${_personnelInfo!['lastName']}'),
              Text('phone number: ${_personnelInfo!['phoneNumber']}'),
              Text('Department: ${_personnelInfo!['department']}'),
              Row(
                children: [
                  Text('Available: '),
                  Text(
                    _personnelInfo!['available'] ? 'Yes' : 'No',
                    style: TextStyle(
                      color: _personnelInfo!['available']
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Set Availability: '),
                  DropdownButton<bool>(
                    value: _personnelInfo!['available'],
                    onChanged: (newValue) {
                      setState(() {
                        _personnelInfo!['available'] = newValue!;
                        _changeAvailability(newValue);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Available'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Unavailable'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
