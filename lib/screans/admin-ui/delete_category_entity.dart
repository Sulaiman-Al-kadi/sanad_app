import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCategoryEntity extends StatefulWidget {
  const DeleteCategoryEntity({Key? key}) : super(key: key);

  @override
  _DeleteCategoryEntityState createState() => _DeleteCategoryEntityState();
}

class _DeleteCategoryEntityState extends State<DeleteCategoryEntity> {
  final TextEditingController _deleteController = TextEditingController();
  String? _selectedOption;
  String? _selectedCategory;
  String? _selectedEntity;
  List<String> _options = ['Category', 'Entity'];
  List<String> _categories = [];
  List<String> _entities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حذف تصنيف أو فئة من النظام'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("entity = فئة category = ملاحظة : تصنيف  "),
              DropdownButton<String>(
                value: _selectedOption,
                hint: Text('الرجاء الاختيار'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                    _selectedCategory = null;
                    _selectedEntity = null;
                    _categories = [];
                    _entities = [];
                    if (_selectedOption == 'Category') {
                      _fetchCategories();
                    }
                    // Call _fetchEntities when the user selects the "Entity" option
                    else if (_selectedOption == 'Entity') {
                      _fetchCategories(); // Fetch categories first
                    }
                  });
                },
                items: _options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              if (_selectedOption == 'Category')
                DropdownButton<String>(
                  value: _selectedCategory,
                  hint: Text('اختر تصنيف لحذفه'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items:
                      _categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              if (_selectedOption == 'Entity' && _categories.isNotEmpty)
                DropdownButton<String>(
                  value: _selectedCategory,
                  hint: Text('اختر تصنيف لحذفها'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                      _entities = [];
                      _fetchEntities();
                    });
                  },
                  items:
                      _categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16.0),
              if (_selectedOption == 'Entity' &&
                  _selectedCategory != null &&
                  _entities.isNotEmpty)
                DropdownButton<String>(
                  value: _selectedEntity,
                  hint: Text('اختر فئة لحذفها'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEntity = newValue;
                    });
                  },
                  items:
                      _entities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_selectedOption == 'Category' &&
                      _selectedCategory != null) {
                    _deleteCategory(_selectedCategory!);
                  } else if (_selectedOption == 'Entity' &&
                      _selectedEntity != null) {
                    _deleteEntity(_selectedEntity!);
                  }
                },
                child: Text('حذف'),
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<void> _fetchEntities() async {
    final entities = await FirebaseFirestore.instance
        .collection('entity')
        .where('category', isEqualTo: _selectedCategory)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
    setState(() {
      _entities = entities;
    });
  }

  void _deleteCategory(String category) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Delete category document
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('entity')
          .where('category', isEqualTo: category)
          .get();

      // Delete all entities associated with the category
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      // Delete the category itself
      await FirebaseFirestore.instance
          .collection('category')
          .where('name', isEqualTo: category)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          batch.delete(doc.reference);
        });
      });

      // Commit the batch
      await batch.commit();

      // Update categories list after deletion
      _fetchCategories();

      _showAlert('نجاح: تم حذف التصنيف والفئة المرتبطة بنجاح');
      _selectedCategory = null;
    } catch (e) {
      print('Error deleting category and entities: $e');
      _showAlert('خطأ   : فشل في حذف التصنيف والفئة المرتبطة');
    }
  }

  void _deleteEntity(String entity) async {
    try {
      await FirebaseFirestore.instance
          .collection('entity')
          .where('name', isEqualTo: entity)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      // Update entities list after deletion
      _fetchEntities();

      _showAlert('نجاح: تم حذف الفئة بنجاح');
      _selectedEntity = null;
    } catch (e) {
      print('Error deleting entity: $e');
      _showAlert('خطأ: فشل في حذف الفئة');
    }
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
}
