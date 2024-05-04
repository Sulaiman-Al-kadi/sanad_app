// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class AddEmplyee extends StatelessWidget {
//   AddEmplyee({super.key});
//   String? firstName;
//   String? lastName;
//   String? phone;
//   String? email;
//   final _firestorer = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("اضافة موظف جديد"), backgroundColor: Colors.blue),
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 50),
//               TextField(
//                 onChanged: (value) {
//                   firstName = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'الأسم الأول',
//                   prefixIcon: Icon(Icons.label_important),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 onChanged: (value) {
//                   lastName = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'اسم العائلة',
//                   prefixIcon: Icon(Icons.label_important),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 onChanged: (value) {
//                   phone = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'رقم الهاتف',
//                   prefixIcon: Icon(Icons.label_important),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 onChanged: (value) {
//                   email = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'البريد الالكتروني',
//                   prefixIcon: Icon(Icons.label_important),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               MaterialButton(
//                 elevation: 5.0,
//                 color: Color.fromARGB(255, 4, 131, 234),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
//                 // ignore: sort_child_properties_last
//                 child: const Text(
//                   'اضافة موظف جديد',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 254, 254, 254),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 shape: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(50),
//                   borderSide: BorderSide.none,
//                 ),
//                 onPressed: () async {
//                   await _firestorer.collection('user').add({
//                     'FirstName': firstName,
//                     'LastName': lastName,
//                     'PhoneNumber': phone,
//                     'email': email,
//                   });
//                   Navigator.of(context).pushNamed("/admin_homepage");
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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

      _showAlert('Success: Department updated successfully');
    } catch (e) {
      print('Error updating department: $e');
      _showAlert('Error: Failed to update department');
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
        title: Text('Update Department'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedManager,
              hint: Text('Select Manager'),
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
              hint: Text('Select Department'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDepartment = newValue;
                });
              },
              items: _departments.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateDepartment,
              child: Text('Update Department'),
            ),
          ],
        ),
      ),
    );
  }
}
