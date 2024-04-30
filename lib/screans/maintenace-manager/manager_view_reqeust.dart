import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestListPage extends StatelessWidget {
  const RequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final requests = snapshot.data!.docs;

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index].data() as Map<String, dynamic>;
                final requestId = requests[index].id; // Get the document ID

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Category: ${request['category']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Entity: ${request['entity']}'),
                        Text('Description: ${request['description']}'),
                        Text('State: ${request['state']}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestDetailPage(
                              request: request,
                              requestId: requestId,
                              documentId: '',
                            ),
                          ),
                        );
                      },
                      child: Text('View'),
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

// class RequestDetailPage extends StatelessWidget {
//   final Map<String, dynamic> request;
//   final String requestId; // Document ID

//   const RequestDetailPage({Key? key, required this.request, required this.requestId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Request Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Category: ${request['category']}'),
//             Text('Entity: ${request['entity']}'),
//             Text('Description: ${request['description']}'),
//             Text('State: ${request['state']}'),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _updateRequestState(requestId, 'In progress');
//                   },
//                   child: Text('Assign Request'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _updateRequestState(requestId, 'Canceled');
//                   },
//                   child: Text('Request Cancellation'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _updateRequestState(String requestId, String newState) {
//     FirebaseFirestore.instance.collection('requests').doc(requestId).update({
//       'state': newState,
//     }).then((_) {
//       print('Request state updated to $newState');
//     }).catchError((error) {
//       print('Failed to update request state: $error');
//     });
//   }
// }

enum RequestState {
  onRequestPool,
  assigned,
  onProgress,
  finished,
  canceled,
}

class RequestDetailPage extends StatefulWidget {
  final Map<String, dynamic> request;

  const RequestDetailPage(
      {Key? key,
      required this.request,
      required String documentId,
      required String requestId})
      : super(key: key);

  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  RequestState _currentState = RequestState.onRequestPool;
  String? _selectedMaintenancePersonnelEmail;
  Map<String, String> _maintenancePersonnelMap = {};

  @override
  void initState() {
    super.initState();
    _fetchMaintenancePersonnelMap();
  }

  Future<void> _fetchMaintenancePersonnelMap() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Maintenance Personnel')
        .get();
    setState(() {
      _maintenancePersonnelMap = Map.fromEntries(querySnapshot.docs
          .map((doc) => MapEntry(doc['email'], doc['email'])));
    });
  }

  Future<void> _assignRequestToMaintenancePersonnel() async {
    // Update Firestore document with assigned maintenance personnel email and change state to Assigned
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(widget.request['id'])
        .update({
      'assignedTo': _selectedMaintenancePersonnelEmail,
      'state': RequestState.onProgress.toString().split('.').last,
    });

    setState(() {
      _currentState = RequestState.onProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${widget.request['category']}'),
            Text('Entity: ${widget.request['entity']}'),
            Text('Description: ${widget.request['description']}'),
            // Add more details as needed
            SizedBox(height: 20),
            // Display current state
            Text('State: $_currentState'),
            // Dropdown to select maintenance personnel
            DropdownButtonFormField<String>(
              value: _selectedMaintenancePersonnelEmail,
              onChanged: (newValue) {
                setState(() {
                  _selectedMaintenancePersonnelEmail = newValue;
                });
              },
              items: _maintenancePersonnelMap.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              hint: Text('Select Maintenance Personnel'),
            ),
            // Button to assign request to selected maintenance personnel
            if (_currentState == RequestState.onRequestPool)
              ElevatedButton(
                onPressed: _selectedMaintenancePersonnelEmail != null
                    ? _assignRequestToMaintenancePersonnel
                    : null,
                child: Text('Assign to Maintenance Personnel'),
              ),
          ],
        ),
      ),
    );
  }
}



// class RequestDetailPage extends StatefulWidget {
//   final Map<String, dynamic> request;

//   const RequestDetailPage({Key? key, required this.request, required String requestId}) : super(key: key);

//   @override
//   _RequestDetailPageState createState() => _RequestDetailPageState();
// }

// class _RequestDetailPageState extends State<RequestDetailPage> {
//   RequestState _currentState = RequestState.onRequestPool;
//   String? _selectedMaintenancePersonnelId;
//   List<String> _maintenancePersonnelIds = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchMaintenancePersonnelIds();
//   }

//   Future<void> _fetchMaintenancePersonnelIds() async {
//     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('userType', isEqualTo: 'Maintenance Personnel')
//         .get();
//     setState(() {
//       _maintenancePersonnelIds = querySnapshot.docs.map((doc) => doc.id).toList();
//     });
//   }

//   Future<void> _assignRequestToMaintenancePersonnel() async {
//     // Update Firestore document with assigned maintenance personnel ID and change state to Assigned
//     await FirebaseFirestore.instance.collection('requests').doc(widget.request['id']).update({
//       'assignedTo': _selectedMaintenancePersonnelId,
//       'state': RequestState.onProgress.toString().split('.').last,
//     });

//     setState(() {
//       _currentState = RequestState.onProgress;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Request Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Category: ${widget.request['category']}'),
//             Text('Entity: ${widget.request['entity']}'),
//             Text('Description: ${widget.request['description']}'),
//             // Add more details as needed
//             SizedBox(height: 20),
//             // Display current state
//             Text('State: $_currentState'),
//             // Dropdown to select maintenance personnel
//             DropdownButtonFormField<String>(
//               value: _selectedMaintenancePersonnelId,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedMaintenancePersonnelId = newValue;
//                 });
//               },
//               items: _maintenancePersonnelIds.map((id) {
//                 return DropdownMenuItem(
//                   value: id,
//                   child: Text(id),
//                 );
//               }).toList(),
//               hint: Text('Select Maintenance Personnel'),
//             ),
//             // Button to assign request to selected maintenance personnel
//             if (_currentState == RequestState.onRequestPool)
//               ElevatedButton(
//                 onPressed: _selectedMaintenancePersonnelId != null ? _assignRequestToMaintenancePersonnel : null,
//                 child: Text('Assign to Maintenance Personnel'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

