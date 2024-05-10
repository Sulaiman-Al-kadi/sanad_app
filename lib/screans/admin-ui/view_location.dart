import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class LocationData extends StatefulWidget {
  LocationData({Key? key}) : super(key: key);

  @override
  _LocationDataState createState() => _LocationDataState();
}

class _LocationDataState extends State<LocationData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedBuilding;
  String? selectedFloor;
  final Map<String, bool> _selectedQRs = {};

  Future<void> exportQRsToPDF(List<Map<String, String>> qrDataList) async {
    final pdf = pw.Document();

    for (var qrData in qrDataList) {
      final image = pw.MemoryImage(base64Decode(qrData['qrCode']!));
      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Center(
              child: pw.Column(
                children: [
                  pw.Text('Building: ${qrData['building']}',
                      style: pw.TextStyle(fontSize: 24)),
                  pw.Text('Floor: ${qrData['floor']}',
                      style: pw.TextStyle(fontSize: 24)),
                  pw.Text('Room: ${qrData['room']}',
                      style: pw.TextStyle(fontSize: 24)),
                  pw.Text('Suite: ${qrData['suite']}',
                      style: pw.TextStyle(fontSize: 24)),
                  pw.SizedBox(height: 20),
                  pw.Image(image),
                ],
              ),
            );
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/qr_codes.pdf");
    await file.writeAsBytes(await pdf.save());

    final xFile = XFile(file.path);
    Share.shareXFiles([xFile], text: 'Here are your selected QR codes');
  }

  Future<void> _showMessage(String title, String message) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmAndPrint(List<Map<String, String>> qrDataList,
      {bool printAll = false}) async {
    if (!printAll && qrDataList.isEmpty) {
      await _showMessage(
          'No QR codes selected', 'Please select at least one QR code.');
      return;
    }

    final message = printAll
        ? 'Are you sure you want to print all the QR codes in the system: ${qrDataList.length}?'
        : 'Are you sure you want to print ${qrDataList.length} selected QR code(s)?';

    final shouldPrint = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Print'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Print'),
            ),
          ],
        );
      },
    );

    if (shouldPrint == true) {
      await exportQRsToPDF(qrDataList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض المواقع'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            tooltip: 'Print selected QR codes',
            onPressed: () async {
              final selectedData = _selectedQRs.keys
                  .where((key) => _selectedQRs[key] == true)
                  .map((key) {
                final data = key.split('|');
                return {
                  'building': data[0],
                  'floor': data[1],
                  'room': data[2],
                  'suite': data[3],
                  'qrCode': data[4],
                };
              }).toList();

              await _confirmAndPrint(selectedData);
            },
          ),
          IconButton(
            icon: Icon(Icons.all_out_outlined),
            tooltip: 'Print all QR codes',
            onPressed: () async {
              final allQRData = await _firestore.collection('location').get();
              final allData = allQRData.docs.map((doc) {
                return {
                  'building': doc['building'].toString(),
                  'floor': doc['floor'].toString(),
                  'room': doc['room'].toString(),
                  'suite': doc['suite'].toString(),
                  'qrCode': doc['qrCode'].toString(),
                };
              }).toList();

              await _confirmAndPrint(allData, printAll: true);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildBuildingDropdown(),
            _buildFloorDropdown(),
            _buildQrList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildingDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('location').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data!.docs;
        final buildings = documents.map((e) => e['building']).toSet().toList();

        return DropdownButton<String>(
          hint: Text("اختر المبنى"),
          value: selectedBuilding,
          items: buildings
              .map((building) => DropdownMenuItem<String>(
                    value: building,
                    child: Text(building),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedBuilding = value;
              selectedFloor = null; // Reset the selected floor
            });
          },
        );
      },
    );
  }

  Widget _buildFloorDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: selectedBuilding != null
          ? _firestore
              .collection('location')
              .where('building', isEqualTo: selectedBuilding)
              .snapshots()
          : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (selectedBuilding == null) {
          return Container(); // Do not show anything if no building is selected
        }

        final documents = snapshot.data!.docs;
        final floors = documents.map((e) => e['floor']).toSet().toList();

        return DropdownButton<String>(
          hint: Text("اختر الطابق"),
          value: selectedFloor,
          items: floors
              .map((floor) => DropdownMenuItem<String>(
                    value: floor,
                    child: Text(floor),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedFloor = value;
            });
          },
        );
      },
    );
  }

  Widget _buildQrList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: (selectedBuilding != null && selectedFloor != null)
            ? _firestore
                .collection('location')
                .where('building', isEqualTo: selectedBuilding)
                .where('floor', isEqualTo: selectedFloor)
                .snapshots()
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (selectedBuilding == null || selectedFloor == null) {
            return Container(); // Do not show anything if no building or floor is selected
          }

          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final building = document['building'];
              final floor = document['floor'];
              final qrCode = document['qrCode'];
              final room = document['room'];
              final suite = document['suite'];

              final key = '$building|$floor|$room|$suite|$qrCode';
              final isSelected = _selectedQRs[key] ?? false;

              return ListTile(
                title: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.memory(
                        base64Decode(qrCode),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('المبنى: $building'),
                    Text('الطابق: $floor'),
                    Text('الغرفة: $room'),
                    Text('ابحناح: $suite'),
                    SizedBox(height: 20),
                  ],
                ),
                leading: Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      _selectedQRs[key] = value ?? false;
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
