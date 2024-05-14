import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

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
        .update({'state': 'cancelled'}).then((_) {
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
        title: Text("الغاء الطلب"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("هل انت متأكد انك تريد الغاء الطلب ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
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
