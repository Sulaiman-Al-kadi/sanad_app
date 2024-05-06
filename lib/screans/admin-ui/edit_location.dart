import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EditLocationPage extends StatefulWidget {
  const EditLocationPage({Key? key}) : super(key: key);

  @override
  _EditLocationPageState createState() => _EditLocationPageState();
}

class _EditLocationPageState extends State<EditLocationPage> {
  final _firestore = FirebaseFirestore.instance;
  String? _selectedBuilding;
  String? _selectedFloor;
  String? _selectedRoom;
  String? _selectedSuite;
  String? _newBuilding;
  String? _newFloor;
  String? _newRoom;
  String? _newSuite;

  List<String> buildings = [];
  List<String> floors = [];
  List<String> rooms = [];
  List<String> suites = [];

  @override
  void initState() {
    super.initState();
    _fetchBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Location'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDropdownButton(
                label: 'Building',
                value: _selectedBuilding,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBuilding = newValue;
                    _selectedFloor = null;
                    _selectedRoom = null;
                    _selectedSuite = null;
                  });
                  _fetchFloors(newValue);
                },
                items: buildings.map((building) {
                  return DropdownMenuItem(
                    value: building,
                    child: Text(building),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              if (_selectedBuilding != null) ...[
                _buildDropdownButton(
                  label: 'Floor',
                  value: _selectedFloor,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFloor = newValue;
                      _selectedRoom = null;
                      _selectedSuite = null;
                    });
                    _fetchRooms(_selectedBuilding, newValue);
                  },
                  items: floors.map((floor) {
                    return DropdownMenuItem(
                      value: floor,
                      child: Text(floor),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                if (_selectedFloor != null) ...[
                  _buildDropdownButton(
                    label: 'Room',
                    value: _selectedRoom,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRoom = newValue;
                        _selectedSuite = null;
                      });
                      _fetchSuites(_selectedBuilding, _selectedFloor, newValue);
                    },
                    items: rooms.map((room) {
                      return DropdownMenuItem(
                        value: room,
                        child: Text(room),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  if (_selectedRoom != null) ...[
                    _buildDropdownButton(
                      label: 'Suite',
                      value: _selectedSuite,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSuite = newValue;
                        });
                      },
                      items: suites.map((suite) {
                        return DropdownMenuItem(
                          value: suite,
                          child: Text(suite),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    _buildTextField('New Building', _newBuilding),
                    SizedBox(height: 8.0),
                    _buildTextField('New Floor', _newFloor),
                    SizedBox(height: 8.0),
                    _buildTextField('New Room', _newRoom),
                    SizedBox(height: 8.0),
                    _buildTextField('New Suite', _newSuite),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _submitChanges();
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton({
    required String label,
    required String? value,
    required Function(String?) onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label),
        SizedBox(height: 8.0),
        DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: items,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String? value) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      initialValue: value,
      onChanged: (newValue) {
        setState(() {
          switch (label) {
            case 'New Building':
              _newBuilding = newValue;
              break;
            case 'New Floor':
              _newFloor = newValue;
              break;
            case 'New Room':
              _newRoom = newValue;
              break;
            case 'New Suite':
              _newSuite = newValue;
              break;
          }
        });
      },
    );
  }

  void _fetchBuildings() {
    FirebaseFirestore.instance
        .collection('location')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<String> buildingList = [];
      querySnapshot.docs.forEach((doc) {
        var building = doc['building'];
        if (!buildingList.contains(building)) {
          buildingList.add(building);
        }
      });
      setState(() {
        buildings = buildingList;
      });
    }).catchError((error) => print("Failed to fetch buildings: $error"));
  }

  void _fetchFloors(String? building) {
    FirebaseFirestore.instance
        .collection('location')
        .where('building', isEqualTo: building)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<String> floorList = [];
      querySnapshot.docs.forEach((doc) {
        var floor = doc['floor'];
        if (!floorList.contains(floor)) {
          floorList.add(floor);
        }
      });
      setState(() {
        floors = floorList;
      });
    }).catchError((error) => print("Failed to fetch floors: $error"));
  }

  void _fetchRooms(String? building, String? floor) {
    FirebaseFirestore.instance
        .collection('location')
        .where('building', isEqualTo: building)
        .where('floor', isEqualTo: floor)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<String> roomList = [];
      querySnapshot.docs.forEach((doc) {
        var room = doc['room'];
        if (!roomList.contains(room)) {
          roomList.add(room);
        }
      });
      setState(() {
        rooms = roomList;
      });
    }).catchError((error) => print("Failed to fetch rooms: $error"));
  }

  void _fetchSuites(String? building, String? floor, String? room) {
    FirebaseFirestore.instance
        .collection('location')
        .where('building', isEqualTo: building)
        .where('floor', isEqualTo: floor)
        .where('room', isEqualTo: room)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<String> suiteList = [];
      querySnapshot.docs.forEach((doc) {
        var suite = doc['suite'];
        if (!suiteList.contains(suite)) {
          suiteList.add(suite);
        }
      });
      setState(() {
        suites = suiteList;
      });
    }).catchError((error) => print("Failed to fetch suites: $error"));
  }

  Future<void> _fetchLocationById(String documentId) async {
    final doc = await FirebaseFirestore.instance
        .collection('location')
        .doc(documentId)
        .get();

    // Now you can set the other variables based on the document data
    setState(() {
      // Set other variables here based on the document data
    });
  }

  void _submitChanges() async {
    if (_selectedBuilding != null &&
        _selectedFloor != null &&
        _selectedRoom != null &&
        _selectedSuite != null) {
      // Query to fetch the document based on current values
      QuerySnapshot querySnapshot = await _firestore
          .collection('location')
          .where('building', isEqualTo: _selectedBuilding)
          .where('floor', isEqualTo: _selectedFloor)
          .where('room', isEqualTo: _selectedRoom)
          .where('suite', isEqualTo: _selectedSuite)
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document to update
        final docRef =
            _firestore.collection('location').doc(querySnapshot.docs.first.id);

        final locationData = {
          'building': _newBuilding,
          'floor': _newFloor,
          'room': _newRoom,
          'suite': _newSuite,
        };

        final qrImageData = await _generateQRCode(locationData);

        // Update the document in Firestore
        await docRef.update({
          'building': _newBuilding ?? _selectedBuilding!,
          'floor': _newFloor ?? _selectedFloor!,
          'room': _newRoom ?? _selectedRoom!,
          'suite': _newSuite ?? _selectedSuite!,
          'qrCode': qrImageData,

          // Add other fields to update as needed
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم تحديث الموقع بنجاح')),
        );

        // Clear input fields and selected values
        setState(() {
          _selectedBuilding = null;
          _selectedFloor = null;
          _selectedRoom = null;
          _selectedSuite = null;
          // Fetch updated data again
          _fetchBuildings();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('يرجى تحديد الموقع أولاً')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى تحديد الموقع أولاً')),
      );
    }
  }

  Future<String> _generateQRCode(Map<String, dynamic> data) async {
    final qrData = jsonEncode(data);
    final imageByteData = await QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: true,
    ).toImageData(200);

    return base64Encode(imageByteData!.buffer.asUint8List());
  }
}
