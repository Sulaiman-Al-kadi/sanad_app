import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sanad_app/screans/user/make_new_request.dart';

class RatingPage extends StatefulWidget {
  final String requestId;
  final Map<String, dynamic> requestData;

  const RatingPage({
    Key? key,
    required this.requestId,
    required this.requestData,
  }) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final TextEditingController _commentController = TextEditingController();

  double _rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قيّمنا'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    'التصنيف: ${widget.requestData['category']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'الفئة: ${widget.requestData['entity']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'وصف المشكلة',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Text(
                    widget.requestData['description'] != ""
                        ? widget.requestData['description']
                        : "لا يوجد وصف",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'تعليق الموظف',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Text(
                    widget.requestData['mpComment'] != "null"
                        ? widget.requestData['mpComment']
                        : "لا يوجد وصف",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'صورة المشكلة بعد الحل',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                                tag: 'mpImage',
                                child: Image.network(
                                  widget.requestData['mpImage'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'mpImage',
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            widget.requestData['mpImage'],
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'هل لديك اي ملاحضات ؟',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Container(
                    margin: EdgeInsets.only(left: 60, right: 3),
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'ادخل تعليقك هنا',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 2),
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'كيف تقيّم خدمتنا ؟',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  RatingBar.builder(
                    itemSize: 50,
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    minWidth: double.maxFinite,
                    onPressed: () async {
                      await _completeRequest();
                    },
                    colorBrightness: Brightness.light,
                    elevation: 2,
                    splashColor: Colors.blue,
                    color: Color.fromARGB(255, 25, 59, 77),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0), width: 1),
                    ),
                    child: Text(
                      'انهاء الطلب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _completeRequest() async {
    try {
      double rating = _rating;
      String feedback = _commentController.text;

      // Update Firestore document
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(widget.requestId)
          .update({
        'rate': rating,
        'userFeedback': feedback,
        'state': 'rated', // Adding the 'state' field
      });

      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم تقييم الخدمة بنجاح'),
          duration: Duration(seconds: 2),
        ),
      );

      // Pop all pages and return to homepage
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (error) {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء تقييم الخدمة'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
