import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelPage extends StatelessWidget {
  final String requestId;
  final Map<String, dynamic> requestData;

  CancelPage({Key? key, required this.requestId, required this.requestData})
      : super(key: key);

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to update the request state to 'canceled'
  Future<void> acceptCancellation() async {
    await _firestore
        .collection('requests')
        .doc(requestId)
        .update({'state': 'canceled'}).then((_) {
      print('Cancellation Accepted');
    }).catchError((error) {
      print('Error updating document: $error');
    });
  }

  // Function to update the request state to 'onProgress'
  Future<void> rejectCancellation() async {
    await _firestore
        .collection('requests')
        .doc(requestId)
        .update({'state': 'onProgress'}).then((_) {
      print('Cancellation Rejected');
    }).catchError((error) {
      print('Error updating document: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Request"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Request ID: $requestId"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Invoke the accept cancellation function
                    acceptCancellation();
                    Navigator.pop(context); // Optionally navigate back
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: Text("قبول"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Invoke the reject cancellation function
                    rejectCancellation();
                    Navigator.pop(context); // Optionally navigate back
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: Text("رفض"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
