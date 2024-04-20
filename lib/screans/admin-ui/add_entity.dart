import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEntity extends StatefulWidget {
  const AddEntity({Key? key}) : super(key: key);

  @override
  _AddEntityState createState() => _AddEntityState();
}

class _AddEntityState extends State<AddEntity> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _entityNameController = TextEditingController();
  final TextEditingController _entityDescriptionController =
      TextEditingController();
  String? _selectedCategory;
  String? _selectedDepartment;
  List<String> _categories = [];
  List<String> _departments = [];
  bool _addCategoryChecked = false;
  bool _addEntityChecked = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchDepartments();
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

  Future<void> _fetchDepartments() async {
    final departments = await FirebaseFirestore.instance
        .collection('department')
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
    setState(() {
      _departments = departments;
    });
  }

  void _addCategory(String category) async {
    if (_categories.contains(category)) {
      _showAlert('Error: Category already exists');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('category').add({
        'name': category,
      });
      _showAlert('Success: Category added successfully');
      _categoryController.clear();
      _fetchCategories();
    } catch (e) {
      print('Error adding category: $e');
      _showAlert('Error: Failed to add category');
    }
  }

  void _addEntity(String name, String description) async {
    if (_selectedCategory == null || _selectedDepartment == null) {
      _showAlert('Error: Please select a category and department');
      return;
    }

    final entityRef = FirebaseFirestore.instance.collection('entity');

    final querySnapshot = await entityRef
        .where('name', isEqualTo: name)
        .where('category', isEqualTo: _selectedCategory)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      _showAlert('Error: Entity already exists in selected category');
      return;
    }

    try {
      await entityRef.add({
        'name': name,
        'description': description,
        'department': _selectedDepartment,
        'category': _selectedCategory,
      });
      _showAlert('Success: Entity added successfully');
      _entityNameController.clear();
      _entityDescriptionController.clear();
    } catch (e) {
      print('Error adding entity: $e');
      _showAlert('Error: Failed to add entity');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ادارة التصنيفات'),
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
                  Checkbox(
                    value: _addCategoryChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _addCategoryChecked = value!;
                        if (_addCategoryChecked) {
                          _addEntityChecked = false;
                        }
                      });
                    },
                  ),
                  Text('Add Category'),
                ],
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                ),
                enabled: _addCategoryChecked,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: _addEntityChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _addEntityChecked = value!;
                        if (_addEntityChecked) {
                          _addCategoryChecked = false;
                        }
                      });
                    },
                  ),
                  Text('Add Entity'),
                ],
              ),
              SizedBox(height: 16.0),
              Text('choose category'),
              IgnorePointer(
                ignoring: !_addEntityChecked,
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: _addEntityChecked
                      ? (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        }
                      : null,
                  items:
                      _categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              Text('choose department'),
              SizedBox(height: 16.0),
              DropdownButton<String>(
                value: _selectedDepartment,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDepartment = newValue;
                  });
                },
                items:
                    _departments.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _entityNameController,
                decoration: InputDecoration(
                  labelText: 'Entity Name',
                ),
                enabled: _addEntityChecked,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _entityDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Entity Description',
                ),
                enabled: _addEntityChecked,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_addCategoryChecked) {
                    String category = _categoryController.text.trim();
                    if (category.isNotEmpty) {
                      _addCategory(category);
                    }
                  } else if (_addEntityChecked) {
                    String name = _entityNameController.text.trim();
                    String description =
                        _entityDescriptionController.text.trim();
                    if (name.isNotEmpty && description.isNotEmpty) {
                      _addEntity(name, description);
                    }
                    Navigator.of(context).pushNamed("/admin_homepage");
                  }
                },
                child:
                    Text(_addCategoryChecked ? 'Add Category' : 'Add Entity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
