// void _changeCategory(String category) async {
//     try {
//       final categoryRef = FirebaseFirestore.instance.collection('category');
//       final querySnapshot =
//           await categoryRef.where('name', isEqualTo: category).get();

//       if (querySnapshot.docs.isNotEmpty) {
//         final docId = querySnapshot.docs.first.id;
//         await categoryRef
//             .doc(docId)
//             .update({'name': _categoryNameController.text});
//         _showAlert('Category changed successfully');
//         setState(() {
//           _categoryNameController.clear();
//           _selectedCategory = null;
//           _selectedEntity = null;
//         });
//       } else {
//         _showAlert('Error: Category not found');
//       }
//     } catch (e) {
//       print('Error changing category: $e');
//       _showAlert('Error: Failed to change category');
//     }
//   }

//   void _changeEntity(String entity) async {
//     try {
//       final entityRef = FirebaseFirestore.instance.collection('entity');
//       final querySnapshot =
//           await entityRef.where('name', isEqualTo: entity).get();

//       if (querySnapshot.docs.isNotEmpty) {
//         final docId = querySnapshot.docs.first.id;
//         await entityRef.doc(docId).update({'name': _entityNameController.text});
//         _showAlert('Entity changed successfully');
//         setState(() {
//           _entityNameController.clear();
//           _selectedCategory = null;
//           _selectedEntity = null;
//         });
//       } else {
//         _showAlert('Error: Entity not found');
//       }
//     } catch (e) {
//       print('Error changing entity: $e');
//       _showAlert('Error: Failed to change entity');
//     }
//   }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

// class AddCategory extends StatelessWidget {
//   AddCategory({super.key});
//   String? category;
//   final _firestorer = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("انشاء تصنيف جديد"), backgroundColor: Colors.blue),
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 50),
//               TextField(
//                 onChanged: (value) {
//                   category = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'اسم التصنيف',
//                   prefixIcon: Icon(Icons.label_important),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(200),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 1.0,
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               MaterialButton(
//                 elevation: 5.0,
//                 color: Color.fromARGB(255, 4, 131, 234),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
//                 // ignore: sort_child_properties_last
//                 child: const Text(
//                   'تسجيل تصنيف جديد',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 254, 254, 254),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 shape: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(50),
//                   borderSide: BorderSide.none,
//                 ),
//                 onPressed: () async {
//                   await _firestorer.collection('category').add({
//                     'name': category,
//                   });
//                   Navigator.of(context).pushNamed("/admin_homepage");
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeCategoryEntity extends StatefulWidget {
  const ChangeCategoryEntity({Key? key}) : super(key: key);

  @override
  _ChangeCategoryEntityState createState() => _ChangeCategoryEntityState();
}

class _ChangeCategoryEntityState extends State<ChangeCategoryEntity> {
  String? _selectedCategory;
  String? _selectedEntity;
  List<String> _categories = [];
  List<String> _entities = [];
  bool _changeCategoryChecked = true;
  bool _changeEntityChecked = false;
  TextEditingController _categoryNameController = TextEditingController();
  TextEditingController _entityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await FirebaseFirestore.instance
        .collection('category')
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _fetchEntities(String category) async {
    final entities = await FirebaseFirestore.instance
        .collection('entity')
        .where('category', isEqualTo: category)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
    setState(() {
      _entities = entities;
    });
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.startsWith('Error') ? 'Error' : 'Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل التصينفات والفئة'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _changeCategoryChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _changeCategoryChecked = value!;
                            _changeEntityChecked = !_changeCategoryChecked;
                            if (_changeCategoryChecked) {
                              _selectedCategory = null;
                              _selectedEntity = null;
                              _fetchCategories();
                            }
                          });
                        },
                      ),
                      Text('Change Category'),
                    ],
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _changeEntityChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _changeEntityChecked = value!;
                            _changeCategoryChecked = !_changeEntityChecked;
                            if (_changeEntityChecked) {
                              _selectedCategory = null;
                              _selectedEntity = null;
                            }
                          });
                        },
                      ),
                      Text('Change Entity'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              if (_changeCategoryChecked)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Choose Category'),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                          _selectedEntity = null;
                          if (_selectedCategory != null) {
                            _fetchEntities(_selectedCategory!);
                          }
                        });
                      },
                      items: _categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _categoryNameController,
                      decoration: InputDecoration(
                        labelText: 'New Category Name',
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Choose Category'),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                          if (_selectedCategory != null) {
                            _fetchEntities(_selectedCategory!);
                          }
                        });
                      },
                      items: _categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Choose Entity'),
                    DropdownButton<String>(
                      value: _selectedEntity,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedEntity = newValue;
                        });
                      },
                      items: _selectedCategory != null
                          ? _entities
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : [],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _entityNameController,
                      decoration: InputDecoration(
                        labelText: 'New Entity Name',
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_changeCategoryChecked &&
                      _selectedCategory != null &&
                      _selectedEntity == null &&
                      _categoryNameController.text.isNotEmpty) {
                    // Change Category
                    _changeCategory(_selectedCategory!);
                  } else if (!_changeCategoryChecked &&
                      _selectedCategory != null &&
                      _selectedEntity != null &&
                      _entityNameController.text.isNotEmpty) {
                    // Change Entity
                    _changeEntity(_selectedEntity!);
                  } else {
                    _showAlert(
                        'Please select a category or entity and provide a name');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeCategory(String category) async {
    try {
      final categoryRef = FirebaseFirestore.instance.collection('category');
      final querySnapshot =
          await categoryRef.where('name', isEqualTo: category).get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await categoryRef
            .doc(docId)
            .update({'name': _categoryNameController.text});
        _showAlert('Category changed successfully');
        setState(() {
          _categoryNameController.clear();
          _selectedCategory = null;
          _selectedEntity = null;
        });
      } else {
        _showAlert('Error: Category not found');
      }
    } catch (e) {
      print('Error changing category: $e');
      _showAlert('Error: Failed to change category');
    }
  }

  void _changeEntity(String entity) async {
    try {
      final entityRef = FirebaseFirestore.instance.collection('entity');
      final querySnapshot =
          await entityRef.where('name', isEqualTo: entity).get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await entityRef.doc(docId).update({'name': _entityNameController.text});
        _showAlert('Entity changed successfully');
        setState(() {
          _entityNameController.clear();
          _selectedCategory = null;
          _selectedEntity = null;
        });
      } else {
        _showAlert('Error: Entity not found');
      }
    } catch (e) {
      print('Error changing entity: $e');
      _showAlert('Error: Failed to change entity');
    }
  }
}
