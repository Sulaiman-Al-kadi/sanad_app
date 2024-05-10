import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sanad_app/screans/user/make_new_request.dart';

class ScanQRPage extends StatefulWidget {
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _showInitialAlert();
  }

  void _showInitialAlert() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('التعليمات'),
              content:
                  Text(' الرجاء مسح الباركود الخاص بالغرفة لإنشاء طلب جديد'),
              actions: <Widget>[
                TextButton(
                  child: Text('حسنا'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الباركود'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Data: ${result!.code}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  : Text('الرجاء مسح الباركود الخاص بالغرفة لإنشاء طلب جديد',
                      style: TextStyle(fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _handleQRCode(scanData.code);
      });
    });
  }

  void _handleQRCode(String? code) {
    if (code != null) {
      try {
        final jsonData = jsonDecode(code);
        if (jsonData is Map<String, dynamic>) {
          final building = jsonData['building'];
          final floor = jsonData['floor'];
          final room = jsonData['room'];
          final suit = jsonData['suite'];

          // Remove previous routes before pushing to the new page
          Navigator.of(context).popUntil((route) => route.isFirst);

          // Navigate to the NewRequest page with the scanned information.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EnhancedRequestPage(
                building: building,
                floor: floor,
                room: room,
                suit: suit,
              ),
            ),
          );
        } else {
          // If JSON is not a Map, handle the error
          _showError('معلومات الباركود غير صحيحة');
        }
      } catch (e) {
        _showError('Error decoding QR code: $e');
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
