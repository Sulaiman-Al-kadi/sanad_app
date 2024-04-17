import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/admin-ui/manage_location.dart';
import 'package:sanad_app/screans/admin-ui/new_category_entity.dart';
import 'package:sanad_app/screans/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
          shadowColor: Colors.grey,
          toolbarHeight: 90,
          backgroundColor: const Color(0xffFDFDFD),
          leading: Transform.translate(
              offset: const Offset(15, 0),
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
                    color: const Color.fromARGB(255, 85, 85, 85),
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
              padding: const EdgeInsets.all(10),
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
              iconSize: 37,
            ),
          ]),
      bottomNavigationBar: Nbar(),
      body: Container(
        width: MediaQuery.of(context).copyWith().size.width,
        child: ListView(shrinkWrap: true, children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                      "images/Screenshot_20240312_003406_WhatsApp.jpg"),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[300],
            ),
            height: 200,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: Text(
                "الخدمات",
                style: GoogleFonts.nunitoSans(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ]),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(boxShadow: [
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

                  GestureDetector(
                    onTapDown: (details) {
                      Navigator.of(context)
                          .pushNamed("/admin_category_enitity");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    15) // Adjust the radius as needed
                                ),
                            child: Image.asset(
                              "images/eugen-str-CrhsIRY3JWY-unsplash.jpg",
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("إدارة التصنيفات",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Text("اضافة/حذف او تعديل التصنيفات",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 211, 210, 210),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Container(
                                height: 15,
                                width: 30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      Navigator.of(context).pushNamed("/admin_location");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    15) // Adjust the radius as needed
                                ),
                            child: Image.asset(
                              "images/pexels-pixabay-159213.jpg",
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("إدارة المواقع",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Text("اضافة/حذف او تعديل المواقع ",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 211, 210, 210),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Container(
                                height: 15,
                                width: 30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      Navigator.of(context).pushNamed("/admin_homepage");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    15) // Adjust the radius as needed
                                ),
                            child: Image.asset(
                              "images/harry-shelton-pPxhM0CRzl4-unsplash.jpg",
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("إدارة الاقسام",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Text("اضافة/حذف او تعديل الاقسام ",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 211, 210, 210),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Container(
                                height: 15,
                                width: 30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      Navigator.of(context).pushNamed("/admin_homepage");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    15) // Adjust the radius as needed
                                ),
                            child: Image.asset(
                              "images/isaac-smith-6EnTPvPPL6I-unsplash.jpg",
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("لوحة التحكم",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Text("إحصائيات تتعلق بالنظام",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 211, 210, 210),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Container(
                                height: 15,
                                width: 30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
