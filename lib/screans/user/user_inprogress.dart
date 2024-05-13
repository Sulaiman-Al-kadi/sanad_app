import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInprogress extends StatefulWidget {
  const UserInprogress({super.key});

  @override
  State<UserInprogress> createState() => _UserInprogressState();
}

class _UserInprogressState extends State<UserInprogress> {
  get email => FirebaseAuth.instance.currentUser?.email;
  void cancelRequest(String requestId) {
    FirebaseFirestore.instance
        .collection('requests')
        .doc(requestId)
        .update({'state': 'cancelled'}).then((value) {
      // Request cancelled successfully
    }).catchError((error) {
      // Handle error
    });
  }

  void showCancelConfirmationDialog(String requestId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تأكيد الإلغاء"),
          content: Text("هل أنت متأكد أنك تريد إلغاء هذا الطلب؟"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                cancelRequest(requestId); // Cancel the request
              },
              child: Text("تأكيد"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 232, 232, 1),
      body: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .where('email', isEqualTo: email)
                .where('state', isEqualTo: 'onProgress')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final requests = snapshot.data!.docs;

                if (requests.isEmpty) {
                  return Center(child: Text('لا يوجد طلبات مكتملة حالياً'));
                }

                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request =
                        requests[index].data() as Map<String, dynamic>;
                    final requestId = requests[index].id.toString();

                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 0.7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('التصنيف : ${request['category']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Text('الفئة: ${request['entity']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  'وصف المشكلة:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${(request['description'] as String).length > 20 ? '${request['description'].toString().substring(0, 20)}...' : request['description']}',
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  showCancelConfirmationDialog(requestId);
                                },
                                child: Text("الغاء الطلب")),
                          ),
                        ));
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
