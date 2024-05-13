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
              child: Text('حسنا'),
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
        title: Center(child: Text('تعديل التصينفات والفئة')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
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
                        Text('تعديل التصنيفات'),
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
                        Text('تغيير التصنيف'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                if (_changeCategoryChecked)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('اختر التصنيف'),
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
                          labelText: 'ادخل الاسم الجديد',
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
                          labelText: 'ادخل الاسم الجديد',
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
                          'خطأ: يجب اختيار التصنيف والفئة وادخال الاسم الجديد للتصنيف او الفئة الجديد');
                    }
                  },
                  child: Text('ارسال'),
                ),
              ],
            ),
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
