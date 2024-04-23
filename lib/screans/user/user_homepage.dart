import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/constants.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
          shadowColor: Colors.grey,
          toolbarHeight: 90,
          backgroundColor: const Color(0xffFDFDFD),
          leading: IconButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
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
                      color: const Color.fromARGB(255, 85, 85, 85),
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
      bottomNavigationBar: const Nbar(),
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                margin: const EdgeInsets.all(10),
                child: Container(
                  height: 25,
                )),
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: Text(
                "الخدمات",
                style: GoogleFonts.nunitoSans(
                  color: const Color.fromARGB(255, 0, 0, 0),
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

                  GestureDetector(
                    onTapDown: (details) {
                      Navigator.of(context).pushNamed("/user_new_request");
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
                              Text("طلب جديد",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Text("قم برفع بلاغ جديد ",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color.fromARGB(
                                        255, 211, 210, 210),
                                    fontSize: 20,
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
                      Navigator.of(context).popAndPushNamed("/user_homepage");
                    },
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
                            Text("حالة الطلب",
                                style: GoogleFonts.nunitoSans(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                )),
                            Text("الاستعلام عن حالة الطلب",
                                style: GoogleFonts.nunitoSans(
                                  color:
                                      const Color.fromARGB(255, 211, 210, 210),
                                  fontSize: 20,
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
                ],
              )),
        ]),
      ),
    );
  }
}
