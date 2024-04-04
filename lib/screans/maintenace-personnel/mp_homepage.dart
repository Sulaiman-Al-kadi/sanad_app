import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/constants.dart';

class MPHomepage extends StatefulWidget {
  const MPHomepage({super.key});

  @override
  State<MPHomepage> createState() => _MPHomepageState();
}

class _MPHomepageState extends State<MPHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
