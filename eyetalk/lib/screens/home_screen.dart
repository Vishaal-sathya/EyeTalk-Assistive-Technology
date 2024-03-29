import 'dart:async';

import 'package:eyetalk/constants.dart';
import 'package:eyetalk/firebase/firebase_service.dart';

import 'package:eyetalk/screens/conversation_screen.dart';

import 'package:eyetalk/screens/alert_screen.dart';
import 'package:eyetalk/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseStringService _firebaseStringService = FirebaseStringService();
  bool lefthover = false;
  bool righthover = false;
  bool downhover = false;

  int timerValue = 500;
  @override
  void initState() {
    super.initState();
    setUI();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: homeScreenAppbar(),
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      leftButtonBuilder(
                          lefthover,
                          "Alert a",
                          "person",
                          CupertinoIcons.exclamationmark_triangle_fill,
                          MediaQuery.of(context).size.height / 1.8,
                          MediaQuery.of(context).size.width / 2.12),
                      rightButtonBuilder(
                          righthover,
                          "Have a",
                          "conversation",
                          CupertinoIcons.person_fill,
                          MediaQuery.of(context).size.height / 1.8,
                          MediaQuery.of(context).size.width / 2.12)
                    ],
                  ),
                  smallButtonBuilder(
                      downhover,
                      "More Options ",
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
                  CupertinoIcons.chevron_left,
                  size: 70,
                  color: getColor(!(hover)),
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
                  CupertinoIcons.right_chevron,
                  size: 70,
                  color: getColor(!(hover)),
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
                  CupertinoIcons.chevron_down,
                  size: 60,
                  color: getColor(!(hover)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void tapHandler(String text) {
    if (text == "") {
      if (righthover) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ConversationScreen()));
      }
      if (lefthover) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RecpipientScreen()));
      }
    }
    if (text == "conversation") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ConversationScreen()));
    }
    if (text == "person") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RecpipientScreen()));
    }
  }

  AppBar homeScreenAppbar() {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
          icon: const Icon(
            Icons.settings_outlined,
            color: Color.fromARGB(255, 242, 240, 240),
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
      print("running");
      if (mounted) {
        setState(() {
          lefthover = lefthover;
          righthover = righthover;
          downhover = downhover;
          if (lefthover) {
            Future.delayed(const Duration(seconds: 2));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecpipientScreen()));
            lefthover = righthover = downhover = false;
          }
          if (righthover) {
            Future.delayed(const Duration(seconds: 2));

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConversationScreen()));
            lefthover = righthover = downhover = false;
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
