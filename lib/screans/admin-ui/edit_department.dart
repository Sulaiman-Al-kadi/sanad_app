// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class EditDepartment extends StatelessWidget {
//   EditDepartment({super.key});

//   final _firestorer = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('تعديل على القسم'),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             StreamBuilder<QuerySnapshot>(
//                 stream: _firestorer.collection('department').snapshots(),
//                 builder: (context, snapshot) {
//                   List<Text> depName = [];

//                   if (!snapshot.hasData) {

//                   }
//                   final texts = snapshot.data!.docs;
//                   for (var t in texts) {
//                     final text = t.get('name');
//                     final w = Text(
//                       '$text',
//                     );
//                     depName.add(w);
//                   }

//                   return Column(
//                     children: depName,
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDepartment extends StatefulWidget {
  EditDepartment({Key? key}) : super(key: key);

  @override
  _EditDepartmentState createState() => _EditDepartmentState();
}

class _EditDepartmentState extends State<EditDepartment> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController _departmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Department'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('department').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<DocumentSnapshot> departments = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: departments.length,
                    itemBuilder: (context, index) {
                      String departmentName = departments[index].get('name');
                      return ListTile(
                        title: Text(departmentName),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editDepartmentName(context, departmentName);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editDepartmentName(BuildContext context, String currentName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Department Name'),
          content: TextField(
            controller: _departmentNameController,
            decoration: InputDecoration(hintText: 'Enter new department name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newName = _departmentNameController.text.trim();
                if (newName.isNotEmpty) {
                  await _updateDepartmentName(currentName, newName);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid department name'),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateDepartmentName(String currentName, String newName) async {
    try {
      // Query the department document by name
      QuerySnapshot querySnapshot = await _firestore
          .collection('department')
          .where('name', isEqualTo: currentName)
          .get();

      // Check if there's any document found
      if (querySnapshot.docs.isNotEmpty) {
        // Update the first document found with the new name
        await querySnapshot.docs.first.reference.update({'name': newName});

        // Update department name in 'entity' collection
        QuerySnapshot entitySnapshot = await _firestore
            .collection('entity')
            .where('department', isEqualTo: currentName)
            .get();
        for (DocumentSnapshot doc in entitySnapshot.docs) {
          await doc.reference.update({'department': newName});
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Department name updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Department not found'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update department name: $e'),
        ),
      );
    }
  }
}
