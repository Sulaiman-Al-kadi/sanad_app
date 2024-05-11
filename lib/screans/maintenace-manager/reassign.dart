import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReassignPage extends StatefulWidget {
  final String requestId;
  final Map<String, dynamic> requestData;

  ReassignPage({Key? key, required this.requestId, required this.requestData})
      : super(key: key);

  @override
  _ReassignPageState createState() => _ReassignPageState();
}

class _ReassignPageState extends State<ReassignPage> {
  String? _selectedPersonEmail;
  List<DropdownMenuItem<String>> _dropdownMenuItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchPersonnel();
  }

  Future<void> fetchPersonnel() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('userType', isEqualTo: 'Maintenance Personnel')
        .get();
    List<DropdownMenuItem<String>> items = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data =
          doc.data() as Map<String, dynamic>; // Cast to avoid runtime error.
      return DropdownMenuItem<String>(
        value: data['email'], // Use email as the value for the dropdown
        child: Text(data['Firstname'] ??
            'Unnamed'), // Safely access 'name' with a fallback.
      );
    }).toList();

    if (mounted) {
      setState(() {
        _dropdownMenuItems = items;
      });
    }
  }

  Future<void> reassignRequest() async {
    if (_selectedPersonEmail != null) {
      await _firestore
          .collection('requests')
          .doc(widget.requestId)
          .update({'assignedTo': _selectedPersonEmail}).then((_) {
        print('Request reassigned to $_selectedPersonEmail');
        Navigator.pop(context); // Navigate back after updating
      }).catchError((error) {
        print('Error updating document: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reassign Request"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Request ID: ${widget.requestId}"),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedPersonEmail,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedPersonEmail = value;
                });
              },
              hint: Text('Select Personnel by Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                reassignRequest();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Reassign"),
            ),
          ],
        ),
      ),
    );
  }
}
