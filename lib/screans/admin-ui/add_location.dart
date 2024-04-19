// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

// class AddLocation extends StatelessWidget {
//   AddLocation({super.key});
//   GlobalKey<FormState> formState = GlobalKey();

//   String? building;
//   String? floor;
//   String? room;
//   String? suit;
//   final _firestorer = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("تسجيل موقع جديد")),
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
//                   building = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'اسم المبنى',
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
//               TextField(
//                 onChanged: (value) {
//                   floor = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'رقم الطابق ',
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
//               TextField(
//                 onChanged: (value) {
//                   room = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'اسم الغرفة  ',
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
//               TextField(
//                 onChanged: (value) {
//                   suit = value;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'اسم الجناح ',
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
//                   'تسجيل موقع جديد',
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
//                   await _firestorer.collection('location').add({
//                     'building': building,
//                     'floor': floor,
//                     'room': room,
//                     'suit': suit,
//                   });
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return MyHomePage();
//                   }));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data'; // Add this import for Uint8List
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddLocation extends StatefulWidget {
  AddLocation({Key? key}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _suiteController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل موقع جديد"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                TextFormField(
                  controller: _buildingController,
                  decoration: InputDecoration(
                    hintText: 'اسم المبنى',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم المبنى';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _floorController,
                  decoration: InputDecoration(
                    hintText: 'رقم الطابق',
                    prefixIcon: Icon(Icons.layers),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال رقم الطابق';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _roomController,
                  decoration: InputDecoration(
                    hintText: 'اسم الغرفة',
                    prefixIcon: Icon(Icons.room),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم الغرفة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _suiteController,
                  decoration: InputDecoration(
                    hintText: 'اسم الجناح',
                    prefixIcon: Icon(Icons.account_balance),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم الجناح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final building = _buildingController.text.trim();
                      final floor = _floorController.text.trim();
                      final room = _roomController.text.trim();
                      final suite = _suiteController.text.trim();
                      final locationData = {
                        'building': building,
                        'floor': floor,
                        'room': room,
                        'suite': suite,
                      };

                      final qrImageData = await _generateQRCode(locationData);

                      // Save location data and QR code in Firebase
                      await _firestore.collection('location').add({
                        'building': building,
                        'floor': floor,
                        'room': room,
                        'suite': suite,
                        'qrCode': qrImageData,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم إضافة الموقع بنجاح')),
                      );
                    }
                  },
                  child: Text('تسجيل موقع جديد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _generateQRCode(Map<String, dynamic> data) async {
    final qrData = jsonEncode(data);
    final imageByteData = await QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: false,
    ).toImageData(200);

    return base64Encode(imageByteData!.buffer.asUint8List());
  }
}
