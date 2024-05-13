import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteLocation extends StatefulWidget {
  const DeleteLocation({super.key});

  @override
  _DeleteLocationState createState() => _DeleteLocationState();
}

class _DeleteLocationState extends State<DeleteLocation> {
  String? _selectedBuilding;
  String? _selectedFloor;
  String? _selectedRoom;
  String? _selectedSuite;

  List<String> _buildings = [];
  List<String> _floors = [];
  List<String> _rooms = [];
  List<String> _suites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('حذف موقع')),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton<String>(
                value: _selectedBuilding,
                hint: Text('اختر المبنى'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBuilding = newValue;
                    _selectedFloor = null; // Reset selected floor
                    _selectedRoom = null; // Reset selected room
                    _selectedSuite = null; // Reset selected suite
                    _floors = []; // Reset floors list
                    _fetchFloors(
                        newValue!); // Fetch floors based on selected building
                  });
                },
                items: _buildings.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              if (_selectedBuilding != null)
                DropdownButton<String>(
                  value: _selectedFloor,
                  hint: Text('اختر الطابق'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFloor = newValue;
                      _selectedRoom = null; // Reset selected room
                      _selectedSuite = null; // Reset selected suite
                      _rooms = []; // Reset rooms list
                      _fetchRooms(_selectedBuilding!,
                          newValue!); // Fetch rooms based on selected building and floor
                    });
                  },
                  items: _floors.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16.0),
              if (_selectedFloor != null)
                DropdownButton<String>(
                  value: _selectedRoom,
                  hint: Text('اختر الغرفة'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRoom = newValue;
                      _selectedSuite = null; // Reset selected suite
                      _suites = []; // Reset suites list
                      _fetchSuites(_selectedBuilding!, _selectedFloor!,
                          newValue!); // Fetch suites based on selected building, floor, and room
                    });
                  },
                  items: _rooms.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16.0),
              if (_selectedRoom != null)
                DropdownButton<String>(
                  value: _selectedSuite,
                  hint: Text('اختر الجناح'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSuite = newValue;
                    });
                  },
                  items: _suites.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Check if all fields are selected
                  if (_selectedBuilding != null &&
                      _selectedFloor != null &&
                      _selectedRoom != null &&
                      _selectedSuite != null) {
                    _deleteLocation(_selectedBuilding!, _selectedFloor!,
                        _selectedRoom!, _selectedSuite!);
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

  @override
  void initState() {
    super.initState();
    _fetchBuildings();
  }

  Future<void> _fetchBuildings() async {
    final buildings = await FirebaseFirestore.instance
        .collection('location')
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc['building'] as String)
          .toSet()
          .toList();
    });
    setState(() {
      _buildings = buildings;
    });
  }

  Future<void> _fetchFloors(String building) async {
    final floors = await FirebaseFirestore.instance
        .collection('location')
        .where('building', isEqualTo: building)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc['floor'] as String)
          .toSet()
          .toList();
    });
    setState(() {
      _floors = floors;
    });
  }

  Future<void> _fetchRooms(String building, String floor) async {
    final rooms = await FirebaseFirestore.instance
        .collection('location')
        .where('building', isEqualTo: building)
        .where('floor', isEqualTo: floor)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc['room'] as String)
          .toSet()
          .toList();
    });
    setState(() {
      _rooms = rooms;
    });
  }

  Future<void> _fetchSuites(String building, String floor, String room) async {
    final suites = await FirebaseFirestore.instance
        .collection('location')
        .where('building', isEqualTo: building)
        .where('floor', isEqualTo: floor)
        .where('room', isEqualTo: room)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc['suite'] as String)
          .toSet()
          .toList();
    });
    setState(() {
      _suites = suites;
    });
  }

  void _deleteLocation(
      String building, String floor, String room, String suite) async {
    try {
      await FirebaseFirestore.instance
          .collection('location')
          .where('building', isEqualTo: building)
          .where('floor', isEqualTo: floor)
          .where('room', isEqualTo: room)
          .where('suite', isEqualTo: suite)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
      _showAlert('نجاح: تم حذف الموقع بنجاح');
      // Reset dropdown selections
      setState(() {
        _selectedBuilding = null;
        _selectedFloor = null;
        _selectedRoom = null;
        _selectedSuite = null;
      });
    } catch (e) {
      print('Error deleting location: $e');
      _showAlert('خطأ: حدث خطأ أثناء حذف الموقع');
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
              child: Text('حسنا'),
            ),
          ],
        );
      },
    );
  }
}
