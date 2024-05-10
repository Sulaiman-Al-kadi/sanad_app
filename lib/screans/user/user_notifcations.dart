// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sanad_app/Routes.dart';

// class NotificationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('تقييم الطلبات المكتملة'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('completed')
//             .where('email',
//                 isEqualTo: 
//                     ) // Replace 'user_id' with actual user ID
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//             return ListView(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data() as Map<String, dynamic>;

//                 return ListTile(
//                   title: Text(data['requestId']),
//                   // Display request details and rating option here
//                   // Implement logic to allow user to rate the request
//                 );
//               }).toList(),
//             );
//           }

//           return Center(
//             child: Text('لا توجد طلبات مكتملة بعد.'),
//           );
//         },
//       ),
//     );
//   }
// }
