import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ViewEmployeesPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض معلومات الموظفين '),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Widget> employeeWidgets = [];

          final users = snapshot.data!.docs;
          for (var user in users) {
            String email = user['email'];
            String userType = user['userType'];
            if (userType == 'Manager' || userType == 'Maintenance Personnel') {
              String fname = user['firstName'];
              String lname = user['lastName'];
              String phoneNumber = user['phoneNumber'];

              String department;
              if (user['department'] != 'null') {
                department = user['department'];
              } else {
                department = 'Not assigned';
              }

              employeeWidgets.add(
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Card(
                    elevation: 2,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        'الاسم: $fname $lname',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            ' الوظيفة: $userType',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            ' القسم: $department',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            ' رقم التواصل: $phoneNumber',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }

          return ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: employeeWidgets,
          );
        },
      ),
    );
  }
}
