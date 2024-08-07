import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smarthome/components/constants.dart';
import 'package:smarthome/firebase/firebase_services.dart';
import 'package:smarthome/screens/conversation_screen.dart';
import 'package:smarthome/screens/home_screen.dart';
import 'package:smarthome/screens/medicine_screen.dart';
import 'package:smarthome/screens/settings_screen.dart';
import 'package:smarthome/screens/smart_home_screen.dart';

void main() async {}

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final FirebaseStringService _firebaseStringService = FirebaseStringService();
  bool lefthover = false;
  bool righthover = false;
  bool downhover = false;

  bool PrevLefthover = false;
  bool PrevRighthover = false;
  bool PrevDownhover = false;

  int timerValue = 500;
  @override
  void initState() {
    super.initState();
    setUI();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeScreen2Appbar(),
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      leftButtonBuilder(
                          lefthover,
                          "Medication",
                          "Reminder",
                          Icons.medication,
                          MediaQuery.of(context).size.height / 1.8,
                          MediaQuery.of(context).size.width / 2.12),
                      rightButtonBuilder(
                          righthover,
                          "Smart Home",
                          "Controls",
                          CupertinoIcons.lightbulb_fill,
                          MediaQuery.of(context).size.height / 1.8,
                          MediaQuery.of(context).size.width / 2.12)
                    ],
                  ),
                  smallButtonBuilder(
                      downhover,
                      "Back To Home",
                      Icons.more_horiz,
                      MediaQuery.of(context).size.height / 4.2,
                      MediaQuery.of(context).size.width)
                ],
              )),
        ]));
  }

  Widget leftButtonBuilder(bool hover, String text1, String text2,
      IconData icondata1, double heightValue, double widthValue) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          tapHandler(text2);
        },
        child: Container(
          height: heightValue,
          width: widthValue,
          decoration: BoxDecoration(
              color: getColor(hover), borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.chevron_left_circle_fill,
                  size: 70,
                  color: AppColors.iconColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text1.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!(hover)),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      text2.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!(hover)),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icondata1,
                          size: 70,
                          color: getColor(!(hover)),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rightButtonBuilder(bool hover, String text1, String text2,
      IconData icondata1, double heightValue, double widthValue) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          tapHandler(text2);
        },
        child: Container(
          height: heightValue,
          width: widthValue,
          decoration: BoxDecoration(
              color: getColor((hover)),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text1.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!(hover)),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      text2.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!(hover)),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icondata1,
                          size: 70,
                          color: getColor(!(hover)),
                        ),
                      ],
                    )
                  ],
                ),
                Icon(
                  CupertinoIcons.chevron_right_circle_fill,
                  size: 70,
                  color: AppColors.iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget smallButtonBuilder(bool hover, String text1, IconData icondata1,
      double heightValue, double widthValue) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          tapHandler(text1);
        },
        child: Container(
          height: heightValue,
          width: widthValue,
          decoration: BoxDecoration(
              color: getColor(hover), borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  text1.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontSize: 40,
                      color: getColor(!(hover)),
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  CupertinoIcons.arrow_down_circle_fill,
                  size: 60,
                  color: AppColors.iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// tap handler handles clicks in different ways, if text is provided it is a regualr click, if not it works by iris tracking
  void tapHandler(String text) {
    if (text == "Reminder") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MedicineScreen()));
    }
    if (text == "Controls") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SmartHome()));
    }
    if (text == "Back To Home") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  AppBar HomeScreen2Appbar() {
    return AppBar(
      backgroundColor: AppColors.appbarColor2,
      title: Center(
        child: changingText(),
      ),
      actions: [
        // ElevatedButton(
        //     onPressed: () => tapHandler(""),
        //     child: Text(
        //       "Placeholder",
        //       style: GoogleFonts.montserrat(
        //           fontSize: 25,
        //           color: AppColors.textColor,
        //           fontWeight: FontWeight.bold),
        //     )),
        IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
          icon: Icon(
            Icons.settings_outlined,
            color: AppColors.iconColor,
          ),
        ),
      ],
    );
  }

  StreamBuilder<String> changingText() {
    return StreamBuilder<String>(
      stream: _firebaseStringService.getLatestString(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String eyeLocation = snapshot.data ?? 'No data received';

          if (eyeLocation == "Looking left") {
            lefthover = true;
            righthover = false;
            downhover = false;
          }
          if (eyeLocation == "Looking right") {
            lefthover = false;
            righthover = true;
            downhover = false;
          }
          if (eyeLocation == "Looking down") {
            lefthover = false;
            righthover = false;
            downhover = true;
          }

          return Text(
            eyeLocation,
            style: GoogleFonts.montserrat(
                fontSize: 25,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold),
          );
        }
      },
    );
  }

  void setUI() {
    Timer.periodic(Duration(milliseconds: timerValue), (timer) {
      if (mounted) {
        setState(() {
          lefthover = lefthover;
          righthover = righthover;
          downhover = downhover;
          if (lefthover) {
            PrevDownhover = false;
            PrevRighthover = false;
            if (PrevLefthover) {
              Navigation.counter++;
            } else {
              PrevLefthover = true;
              Navigation.counter = 0;
            }

            if (Navigation.counter >= Navigation.delayDuration) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicineScreen()));
              lefthover = righthover = downhover = false;
              Navigation.counter = 0;
              PrevLefthover = false; // Reset counter
            }
          }
          if (righthover) {
            PrevDownhover = false;
            PrevLefthover = false;
            if (PrevRighthover) {
              Navigation.counter++;
            } else {
              PrevRighthover = true;
              Navigation.counter = 0;
            }
            if (Navigation.counter >= Navigation.delayDuration) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SmartHome()));
              lefthover = righthover = downhover = false;
              Navigation.counter = 0; // Reset counter
            }
          }
          if (downhover) {
            PrevRighthover = false;
            PrevLefthover = false;
            if (PrevDownhover) {
              Navigation.counter++;
            } else {
              PrevDownhover = true;
              Navigation.counter = 0;
            }
            if (Navigation.counter >= Navigation.delayDuration) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
              lefthover = righthover = downhover = false;
              Navigation.counter = 0; // Reset counter
            }
          }
        });
      }
    });
  }

  Color getColor(bool hover) {
    if (hover) {
      return AppColors.textColor;
    } else {
      return AppColors.boxBackground2;
    }
  }
}
