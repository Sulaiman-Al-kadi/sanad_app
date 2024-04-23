// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:sanad_app/screans/user/make_new_request.dart';

// class ScanQRPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _ScanQRPageState();
// }

// class _ScanQRPageState extends State<ScanQRPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or dispose the controller if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.blue,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: MediaQuery.of(context).size.width * 0.8,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? Text(
//                       'Data: ${result!.code}',
//                       textAlign: TextAlign.center,
//                     )
//                   : Text('Scan a code'),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//         _handleQRCode(scanData.code);
//       });
//     });
//   }

//   void _handleQRCode(String? code) {
//     if (code != null) {
//       try {
//         final jsonData = jsonDecode(code);
//         if (jsonData is Map<String, dynamic>) {
//           // Extracting data from the scanned QR code
//           final building = jsonData['building'];
//           final floor = jsonData['floor'];
//           final room = jsonData['room'];
//           final suit = jsonData['suit'];

//           // You can now use this data as needed, for example, show a dialog with the info
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('QR Code Data'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Building: $building'),
//                   Text('Floor: $floor'),
//                   Text('Room: $room'),
//                   Text('Suit: $suit'),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       } catch (e) {
//         print('Error decoding QR code: $e');
//         // Handle the exception by showing an error message or similar
//       }

//       // ... (QR scanning logic)

//       void _handleQRCode(String? code) {
//         if (code != null) {
//           try {
//             final jsonData = jsonDecode(code);
//             if (jsonData is Map<String, dynamic>) {
//               final building = jsonData['building'];
//               final floor = jsonData['floor'];
//               final room = jsonData['room'];
//               final suit = jsonData['suit'];

//               // Navigate to the NewRequest page with the scanned information.
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => NewRequest(
//                     building: building,
//                     floor: floor,
//                     suit: suit,
//                     room: room,
//                   ),
//                 ),
//               );
//             }
//           } catch (e) {
//             print('Error decoding QR code: $e');
//             // Handle the exception by showing an error message or similar
//           }
//         }
//       }

// // ... (Rest of the QR scanning page code)
//     }
//   }
// }
