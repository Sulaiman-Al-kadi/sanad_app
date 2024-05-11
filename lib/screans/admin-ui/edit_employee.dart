import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<EditEmployee> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? selectedUserType;
  Map<String, dynamic>? userData;

  Future<void> _searchUser() async {
    final email = _emailController.text.trim();

    if (email.isNotEmpty) {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userDoc = snapshot.docs.first;
        setState(() {
          userData = {
            ...userDoc.data() as Map<String, dynamic>,
            'uid': userDoc.id,
          };
        });
      } else {
        setState(() {
          userData = null;
        });
      }
    }
  }

  Future<void> _updateUserType() async {
    if (userData != null && selectedUserType != null) {
      print('اختر صلاحية المستخدم: $selectedUserType');
      print('User UID: ${userData!['uid']}');
      try {
        await _firestore.collection('users').doc(userData!['uid']).update({
          'userType': selectedUserType,
        });
        // Refresh user data after update
        _searchUser();
        _showSuccessDialog();
      } catch (e) {
        print('Error updating userType: $e');
        _showErrorDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نجاح'),
          content: Text('تم تحديث صلاحية المستخدم بنجاح.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('حسناً'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('فشل تحديث صلاحية المستخدم. حاول مرة أخرى.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('حسناً'),
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
        title: Text("تعديل على فريق العمل"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'ادخل البريد الإلكتروني للمستخدم',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _searchUser,
                child: Text('ابحث عن المستخدم'),
              ),
              SizedBox(height: 20),
              if (userData != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(':معلومات المستخدم'),
                    Text(' : البريد الاكتروني ${userData!['email']}'),
                    Text(':رقم الهاتف ${userData!['phoneNumber']}'),
                    Text(': الاسم الاول ${userData!['firstName']}'),
                    Text(':العائلة ${userData!['lastName']}'),
                    Text(':صلاحية المستخدم ${userData!['userType']}'),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedUserType,
                      onChanged: (value) {
                        setState(() {
                          selectedUserType = value!;
                        });
                      },
                      items: ['User', 'Manager', 'Maintenance Personnel']
                          .map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'اختر صلاحية المستخدم',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _updateUserType();
                        Navigator.of(context).pushNamed("/admin_homepage");
                      },
                      child: Text('تحديث صلاحية المستخدم'),
                    ),
                  ],
                ),
              if (userData == null) Text('!لم يتم العثور على المستخدم'),
            ],
          ),
        ),
      ),
    );
  }
}
