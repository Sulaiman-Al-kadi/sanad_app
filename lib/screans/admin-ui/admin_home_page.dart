import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/SettingsPage.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/admin-ui/manage_location.dart';
import 'package:sanad_app/screans/admin-ui/new_category_entity.dart';
import 'package:sanad_app/screans/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FC),
      appBar: AppBar(
          shadowColor: Colors.grey,
          toolbarHeight: 90,
          backgroundColor: Color(0xffFDFDFD),
          leading: Transform.translate(
              offset: Offset(15, 0),
              child: GestureDetector(
                onTap: () {
                  return print("object");
                },
                child: const CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage("images/تنزيل (3).jpeg"),
                  backgroundColor: Colors.transparent,
                ),
              )),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Welcome,',
                  style: GoogleFonts.nunitoSans(
                    color: Color.fromARGB(255, 85, 85, 85),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('abu Sami!',
                    style: GoogleFonts.nunitoSans(
                      color: const Color.fromARGB(255, 59, 59, 61),
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    )),
              )
            ],
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.all(10),
              onPressed: () {},
              icon: Icon(Icons.notifications_none),
              iconSize: 37,
            ),
          ]),
      bottomNavigationBar: Nbar(),
      body: Container(
        width: MediaQuery.of(context).copyWith().size.width,
        child: ListView(shrinkWrap: true, children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "images/Screenshot_20240312_003406_WhatsApp.jpg"),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[300],
            ),
            height: 200,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                margin: EdgeInsets.all(10),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "تصفح الجميع",
                      style: GoogleFonts.nunitoSans(
                        color: Color.fromARGB(255, 130, 6, 207),
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ))),
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Text(
                "الخدمات",
                style: GoogleFonts.nunitoSans(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ]),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0xffF8F9FC),
                )
              ]),
              height: 200,
              width: 370,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: PageController(
                  viewportFraction: 0.8,
                  initialPage: 0,
                ),
                children: [
                  // Text("page view1 "),
                  // Text("page view2 "),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15) // Adjust the radius as needed
                            ),
                        child: GestureDetector(
                          onTapDown: (details) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CategoryAndEntity(), // Navigate to the settings page
                            ));
                          },
                          child: Image.asset(
                            "images/eugen-str-CrhsIRY3JWY-unsplash.jpg",
                            height: double.maxFinite,
                            width: double.maxFinite,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("إدارة التصنيفات",
                                style: GoogleFonts.nunitoSans(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                )),
                            Text("اضافة/حذف او تعديل تصنيفات موجودة",
                                style: GoogleFonts.nunitoSans(
                                  color: Color.fromARGB(255, 211, 210, 210),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                )),
                          ],
                        ),
                        left: 40,
                        top: 110,
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15) // Adjust the radius as needed
                            ),
                        child: GestureDetector(
                            onTapDown: (details) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManageLocation(),
                              ));
                            },
                            child: Image.asset(
                              "images/pexels-pixabay-159213.jpg",
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("إدارة المواقع",
                                style: GoogleFonts.nunitoSans(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                )),
                            Text("اضافة/حذف او تعديل غرف موجودة",
                                style: GoogleFonts.nunitoSans(
                                  color: Color.fromARGB(255, 211, 210, 210),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                )),
                          ],
                        ),
                        left: 55,
                        top: 110,
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15) // Adjust the radius as needed
                            ),
                        child: GestureDetector(
                            onTapDown: (details) {
                              return print("object");
                            },
                            child: Image.asset(
                              "images/pexels-pixabay-159213.jpg",
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("إدارة المواقع",
                                style: GoogleFonts.nunitoSans(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                )),
                            Text("اضافة/حذف او تعديل غرف موجودة",
                                style: GoogleFonts.nunitoSans(
                                  color: Color.fromARGB(255, 211, 210, 210),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                )),
                          ],
                        ),
                        left: 55,
                        top: 110,
                      )
                    ],
                  ),
                ],
              )),

          ///////////////////////////////////////////////////////////////////////////////////
          // Container(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     "الطلبات الاخيرة",
          //     style: GoogleFonts.nunitoSans(
          //       color: Color.fromARGB(255, 0, 0, 0),
          //       fontSize: 18,
          //       fontWeight: FontWeight.w900,
          //     ),
          //   ),
          // ),
          //   Container(
          //     height: 15,
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Container(
          //           width: 115,
          //           height: 115,
          //           decoration: BoxDecoration(
          //               color: Colors.blue,
          //               borderRadius: BorderRadius.circular(
          //                   15) // Adjust the radius as needed
          //               ),
          //         ),
          //         Container(
          //           width: 115,
          //           height: 115,
          //           decoration: BoxDecoration(
          //               color: Colors.blue,
          //               borderRadius: BorderRadius.circular(
          //                   15) // Adjust the radius as needed
          //               ),
          //         ),
          //         Container(
          //           width: 115,
          //           height: 115,
          //           decoration: BoxDecoration(
          //               color: Colors.blue,
          //               borderRadius: BorderRadius.circular(
          //                   15) // Adjust the radius as needed
          //               ),
          //         )
          //       ],
          //     ),
          //   ),
          ////////////////////////////////////////////////////////////////////////////////
        ]),
      ),
    );
  }
}
