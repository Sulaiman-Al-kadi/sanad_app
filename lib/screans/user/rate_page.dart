// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class Ratepage extends StatefulWidget {
//   const Ratepage({super.key});

//   @override
//   State<Ratepage> createState() => _RatepageState();
// }

// class _RatepageState extends State<Ratepage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Directionality(
//               textDirection: TextDirection.rtl, child: Text('تقييم الخدمة')),
//         ),
//         body: SafeArea(
//             child: Column(
//           children: [
//             Directionality(
//               textDirection: TextDirection.rtl, // add this

//               child: Container(
//                   padding: EdgeInsets.all(20),
//                   child: Column(children: [
//                     Text(
//                       'تقييم الخدمة',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       'كيف تقيم الخدمة التي تلقيتها؟',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Directionality(
//                       textDirection: TextDirection.ltr,
//                       child: Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.star,
//                                 color: Colors.grey,
//                                 size: 40,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.star,
//                                 color: Colors.grey,
//                                 size: 40,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.star,
//                                 color: Colors.grey,
//                                 size: 40,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.star,
//                                 color: Colors.grey,
//                                 size: 40,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   // rating = 5;                                selectedIcon:
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                     size: 50,
//                                   );
//                                 });
//                               },
//                               icon: Icon(
//                                 Icons.star,
//                                 color: Colors.grey,
//                                 size: 40,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('تقييم'),
//                     ),
//                   ])),
//             ),
//           ],
//         )));
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sanad_app/screans/user/make_new_request.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 4.5; // Initial rating
  EnhancedRequestPage img = EnhancedRequestPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قيّمنا'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: <Widget>[

            Text(
              'نوع المشكلة',
              style: TextStyle(fontSize: 28.0),
            ),
            Text(
              'المشكلة بالتحديد',
              style: TextStyle(fontSize: 28.0),
            ),
            Text(
              'الموظف',
              style: TextStyle(fontSize: 28.0),
            ),
            Text(
              'تعليق الموظف',
              style: TextStyle(fontSize: 28.0),
            ),
            Text(
              'صورة المشكلة بعد الحل',
              style: TextStyle(fontSize: 28.0),
            ),
            //  Container(
            //           height: 400,
            //           width: 400,
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.grey),
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //           child:
            //         ),


            Text(
              'هل لديك اي ملاحضات ؟',
              style: TextStyle(fontSize: 28.0),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'أدخل تعليقك هنا',
              ),
            ),
            SizedBox(height: 20.0),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
            SizedBox(height: 20.0),
            Text(
              'Rating: $_rating',
              style: TextStyle(fontSize: 22.0),
            ),
          ],
        ),
      ),
    );
  }
}
