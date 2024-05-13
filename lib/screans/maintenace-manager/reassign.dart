import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReassignPage extends StatefulWidget {
  final Map<String, dynamic> request;
  final String requestId; // Add requestId here

  const ReassignPage({
    Key? key,
    required this.request,
    required this.requestId, // Update constructor to accept requestId
  }) : super(key: key);

  @override
  _ReassignPageState createState() => _ReassignPageState();
}

class _ReassignPageState extends State<ReassignPage> {
  String? _selectedMaintenancePersonnelEmail;
  List<DropdownMenuItem<String>> _dropdownMenuItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchMaintenancePersonnelEmails();
  }

  Future<void> _fetchMaintenancePersonnelEmails() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('userType', isEqualTo: 'Maintenance Personnel')
        .where('department', isEqualTo: widget.request['department'])
        .get();

    List<DropdownMenuItem<String>> items = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String email = data['email'] as String;
      String displayName =
          '${data['firstName'] ?? 'No first name'} ${data['lastName'] ?? 'No last name'}';
      return DropdownMenuItem<String>(
        value: email,
        child: Text(displayName),
      );
    }).toList();

    if (mounted) {
      setState(() {
        _dropdownMenuItems = items;
      });
    }
  }

  Future<void> _reassignRequest() async {
    if (_selectedMaintenancePersonnelEmail != null) {
      await _firestore
          .collection('requests')
          .doc(widget.requestId) // Use widget.requestId here
          .update({
        'assignedTo': _selectedMaintenancePersonnelEmail,
        'state': 'onProgress'
      }).then((_) {
        print('Request reassigned to $_selectedMaintenancePersonnelEmail');
        Navigator.pop(context); // Navigate back after updating
      }).catchError((error) {
        print('Error updating document: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('اعادة توجيه الطلب'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('التصنيف: ${widget.request['category']}'),
              Text('الفئة: ${widget.request['entity']}'),
              Text('لوصف: ${widget.request['description']}'),
              SizedBox(height: 20),
              Text('ايميل المرسل: mp1@gmail.com '), // Display sender's email
              DropdownButtonFormField<String>(
                value: _selectedMaintenancePersonnelEmail,
                onChanged: (newValue) {
                  setState(() {
                    _selectedMaintenancePersonnelEmail = newValue;
                  });
                },
                items: _dropdownMenuItems,
                hint: Text('اختر فني صيانة'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectedMaintenancePersonnelEmail != null
                    ? _reassignRequest
                    : null,
                child: Text('اعادة توجيه الطلب'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
