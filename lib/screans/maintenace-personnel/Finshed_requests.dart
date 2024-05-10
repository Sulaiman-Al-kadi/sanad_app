import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Finished extends StatefulWidget {
  const Finished({Key? key});

  @override
  State<Finished> createState() => _FinishedState();
}

class _FinishedState extends State<Finished> {
  @override
  Widget build(BuildContext context) {
    final String? assignedTo = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 232, 232, 1),
      body: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .where('assignedTo', isEqualTo: assignedTo)
                .orderBy('timestamp', descending: false)
                .where('timestamp',
                    isGreaterThan: DateTime.now().subtract(Duration(days: 30)))
                .where('state', whereIn: ['completed', 'canceled']).snapshots(),
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
                              Row(
                                children: [
                                  Text('التصنيف : ${request['category']}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
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
                            ],
                          ),
                          trailing: Container(
                            child: Text('مكتمل',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 170, 170, 170),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
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
