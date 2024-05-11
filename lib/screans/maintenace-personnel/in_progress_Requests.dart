import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/screans/maintenace-personnel/display_request.dart';

var requestId;

class InprogressPage extends StatefulWidget {
  _InprogressPageState createState() => _InprogressPageState();
}

class _InprogressPageState extends State<InprogressPage> {
  final String? assignedTo = FirebaseAuth.instance.currentUser?.email;

  String fetch_requestId() {
    return requestId;
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
                .where('assignedTo', isEqualTo: assignedTo)
                .orderBy('timestamp', descending: true)
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
                  return Center(child: Text('لا يوجد طلبات قيد التنفيذ حاليا'));
                }

                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request =
                        requests[index].data() as Map<String, dynamic>;
                    requestId = requests[index].id.toString();

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Color.fromARGB(255, 255, 255, 255),
                        elevation: 5,
                        child: ListTileTheme(
                          contentPadding: EdgeInsets.all(30),
                          tileColor: Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'التصنيف : ${request['category']}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  'الفئة: ${request['entity']}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'وصف المشكلة:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${(request['description'] as String).length > 25 ? '${request['description'].toString().substring(0, 25)}...' : request['description']}',
                                ),
                                // Text(
                                //   'منذ: ${(request['timestamp'].asTimestamp() as Timestamp).toDate().toString().substring(0, 16)}',
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       color: const Color.fromARGB(
                                //           255, 117, 72, 224)),
                                // )
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 25, 59, 77)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RequestDetailsPage(
                                      requestId: requestId,
                                      requestData: request,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                                child: Text(
                                  'عرض الطلب',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
