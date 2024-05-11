import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/screans/maintenace-manager/Cnacel.dart';
import 'package:sanad_app/screans/maintenace-manager/reassign.dart';

class InReview extends StatefulWidget {
  const InReview({Key? key}) : super(key: key);

  @override
  State<InReview> createState() => _InReviewState();
}

class _InReviewState extends State<InReview> {
  late String department = ''; // Variable to store the department

  @override
  void initState() {
    super.initState();
    fetchUserDepartment().then((value) {
      setState(() {
        department = value;
      });
    });
  }

  Future<String> fetchUserDepartment() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['department'];
    }
    return ''; // Return empty string if user is not found or department is not available
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
                .where('department', isEqualTo: department)
                .where('state',
                    whereIn: ['reassign', 'askcanceled']).snapshots(),
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text('الفئة: ${request['entity']}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'وصف المشكلة:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${(request['description'] as String).length > 25 ? '${request['description'].toString().substring(0, 25)}...' : request['description']}',
                              ),
                              SizedBox(height: 2),
                            ],
                          ),
                          trailing: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 25, 59, 77)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (request['state'] == 'askcanceled') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CancelPage(
                                      requestId: requestId,
                                      requestData: request,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReassignPage(
                                      requestId: requestId,
                                      requestData: request,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'مراجعة الطلب',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
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
