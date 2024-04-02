import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/SettingsPage.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/constants.dart';
import "package:sanad_app/Routes.dart";

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FC),
      appBar: AppBar(
          shadowColor: Colors.grey,
          toolbarHeight: 90,
          backgroundColor: Color(0xffFDFDFD),
          leading: IconButton(
            padding: EdgeInsets.all(10),
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
            iconSize: 37,
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    'مرحبا',
                    style: GoogleFonts.nunitoSans(
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text('احمد محسن',
                      style: GoogleFonts.nunitoSans(
                        color: const Color.fromARGB(255, 59, 59, 61),
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      )),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                return print("object");
              },
              child: const CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage("images/تنزيل (3).jpeg"),
                backgroundColor: Colors.transparent,
              ),
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
                child: Container(
                  height: 25,
                )),
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Text(
                "الخدمات",
                style: GoogleFonts.nunitoSans(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15,
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
                            print("Object");
                          },
                          child: Image.asset(
                            "",
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
        ]),
      ),
    );
  }
}
