import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InprogressPage extends StatefulWidget {
  @override
  _InprogressPageState createState() => _InprogressPageState();
}

class _InprogressPageState extends State<InprogressPage> {
  final String? assignedTo = FirebaseAuth.instance.currentUser?.email;

  void completeRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .update({
        'state': 'completed',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Request marked as completed"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to complete request: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In Progress Requests"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where('assignedTo', isEqualTo: assignedTo)
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
              return Center(child: Text('No in-progress requests assigned.'));
            }

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index].data() as Map<String, dynamic>;
                final requestId = requests[index].id;

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Category: ${request['category']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Entity: ${request['entity']}'),
                        Text('Description: ${request['description']}'),
                        if (request['image_url'] != null)
                          Image.network(request['image_url'], height: 100),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => completeRequest(requestId),
                      child: Text('Complete'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
