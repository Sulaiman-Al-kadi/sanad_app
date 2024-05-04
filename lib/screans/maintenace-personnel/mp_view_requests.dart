import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaintenancePersonnelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Personnel Page'),
      ),
      body: FutureBuilder<String?>(
        future: _getUserEmail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userEmail = snapshot.data;

            if (userEmail != null) {
              return RequestList(userEmail: userEmail);
            } else {
              return Center(child: Text('User email not available.'));
            }
          }
        },
      ),
    );
  }

  Future<String?> _getUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }
}

class RequestList extends StatelessWidget {
  final String userEmail;

  const RequestList({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('requests')
          .where('assignedTo', isEqualTo: userEmail)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final requests = snapshot.data!.docs;

          if (requests.isEmpty) {
            return Center(child: Text('No requests assigned.'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text('Category: ${request['category']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Entity: ${request['entity']}'),
                    Text('Description: ${request['description']}'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Implement functionality to complete request
                  },
                  child: Text('Complete'),
                ),
              );
            },
          );
        }
      },
    );
  }
}
