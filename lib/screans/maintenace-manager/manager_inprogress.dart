import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sanad_app/screans/maintenace-manager/manager_complete.dart';

var requestId;

class MInprogressPage extends StatefulWidget {
  _MInprogressPageState createState() => _MInprogressPageState();
}

class _MInprogressPageState extends State<MInprogressPage> {
  final String? assignedTo = FirebaseAuth.instance.currentUser?.email;
  String fetch_requestId() {
    return requestId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 232, 232, 1),
      body: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .where('assignedTo', isEqualTo: assignedTo)
                .orderBy('timestamp', descending: true)
                .where('state', isEqualTo: 'onProgress')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final requests = snapshot.data!.docs;

                if (requests.isEmpty) {
                  return Center(child: Text('لا يوجد طلبات قيد التنفيذ حاليا'));
                }

                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request =
                        requests[index].data() as Map<String, dynamic>;
                    requestId = requests[index].id.toString();

                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: Color.fromARGB(255, 255, 255, 255),
                          elevation: 5,
                          child: ListTileTheme(
                            contentPadding: EdgeInsets.all(30),
                            tileColor: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('التصنيف : ${request['category']}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text('الفئة: ${request['entity']}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    'وصف المشكلة:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${(request['description'] as String).length > 25 ? '${request['description'].toString().substring(0, 25)}...' : request['description']}',
                                  ),
                                  // Text(
                                  //   'منذ: ${(request['timestamp'].asTimestamp() as Timestamp).toDate().toString().substring(0, 16)}',
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: const Color.fromARGB(
                                  //           255, 117, 72, 224)),
                                  // )
                                ],
                              ),
                              trailing: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 25, 59, 77)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerRequestDetailsPage(
                                        requestId: requestId,
                                        requestData: request,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'عرض الطلب',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ManagerRequestDetailsPage extends StatefulWidget {
  final String requestId;
  final Map<String, dynamic> requestData;

  const ManagerRequestDetailsPage(
      {Key? key, required this.requestId, required this.requestData})
      : super(key: key);

  @override
  _ManagerRequestDetailsPageState createState() =>
      _ManagerRequestDetailsPageState();
}

class _ManagerRequestDetailsPageState extends State<ManagerRequestDetailsPage> {
  void navigateToValidationPage() async {
    final bool completed = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ManagerCompleteRequestPage(
                requestId: requestId,
                userId: FirebaseAuth.instance.currentUser!.uid,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6.2,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            shadows: [Shadow(color: Colors.grey, blurRadius: 2)]),
        title: Center(
          child: Text(
            "تفاصيل الطلب",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('التصنيف: ${widget.requestData['category']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('الفئة: ${widget.requestData['entity']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('وصف المشكلة:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  if (widget.requestData['description'] != "")
                    Text(widget.requestData['description'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  else
                    Text("لا يوجد وصف",
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                  SizedBox(
                    height: 30,
                  ),
                  Text("صورة الطلب:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text("صورة الطلب"),
                            ),
                            body: Center(
                              child: Hero(
                                tag: 'imageHero',
                                child: Image.network(
                                  widget.requestData['image_url'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            widget.requestData['image_url'],
                            height: 300,
                            width: 300,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                );
                              }
                            },
                          ),
                          // Add loading indicator here
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("موقع الطلب: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("رقم المبنى:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(15),
                            child: Text(widget.requestData['building'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: 8, height: 8),
                      Column(
                        children: [
                          Text("رقم الطابق:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(widget.requestData['floor'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: 8, height: 8),
                      Column(
                        children: [
                          Text("رقم الغرفة:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(widget.requestData['room'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: 8, height: 8),
                      Column(
                        children: [
                          Text("رقم الجناح:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(widget.requestData['suite'].toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'تاريخ الطلب: ${(widget.requestData['timestamp'] as Timestamp).toDate()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  SizedBox(height: 40),
                  Center(
                      child: MaterialButton(
                    minWidth: double.maxFinite,
                    onPressed: navigateToValidationPage,
                    colorBrightness: Brightness.light,
                    elevation: 5.0,
                    splashColor: Colors.blue,
                    color: Color.fromARGB(255, 25, 59, 77),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 253, 253), width: 1),
                    ),
                    child: Text(
                      'استكمال الطلب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
