import 'dart:async';

import 'package:smarthome/components/constants.dart';
import 'package:smarthome/firebase/firebase_services.dart';
import 'package:smarthome/screens/home_screen.dart';
import 'package:smarthome/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class RecpipientScreen extends StatefulWidget {
  const RecpipientScreen({super.key});

  @override
  State<RecpipientScreen> createState() => _RecpipientScreenState();
}

class _RecpipientScreenState extends State<RecpipientScreen> {
  final FirebaseStringService _firebaseStringService = FirebaseStringService();
  bool lefthover = false;
  bool righthover = false;
  bool downhover = false;

  bool PrevLefthover = false;
  bool PrevRighthover = false;
  bool PrevDownhover = false;

  bool inAlert = false;

  Timer? _timer;

  int timerValue = 1000;
  @override
  void initState() {
    super.initState();
    setUI();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed of
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: alertScreenAppbar(),
      body: Stack(children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    leftButtonBuilder(
                        "Alert a",
                        "caretaker",
                        CupertinoIcons.exclamationmark_triangle_fill,
                        MediaQuery.of(context).size.height / 1.8,
                        MediaQuery.of(context).size.width / 2.12),
                    rightButtonBuilder(
                        "Alert the",
                        "doctor",
                        CupertinoIcons.person_fill,
                        MediaQuery.of(context).size.height / 1.8,
                        MediaQuery.of(context).size.width / 2.12)
                  ],
                ),
                smallButtonBuilder(
                    "Return to home",
                    Icons.more_horiz,
                    MediaQuery.of(context).size.height / 4.2,
                    MediaQuery.of(context).size.width)
              ],
            )),
      ]),
    );
  }

  Widget leftButtonBuilder(String text1, String text2, IconData icondata1,
      double heightValue, double widthValue) {
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
              color: getColor(lefthover),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.chevron_left,
                  size: 70,
                  color: getColor(!lefthover),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text1.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!lefthover),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      text2.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!lefthover),
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
                          color: getColor(!lefthover),
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

  Widget rightButtonBuilder(String text1, String text2, IconData icondata1,
      double heightValue, double widthValue) {
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
              color: getColor(righthover),
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
                          color: getColor(!righthover),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      text2.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: getColor(!righthover),
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
                          color: getColor(!righthover),
                        ),
                      ],
                    )
                  ],
                ),
                Icon(
                  CupertinoIcons.right_chevron,
                  size: 70,
                  color: getColor(!righthover),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget smallButtonBuilder(
      String text1, IconData icondata1, double heightValue, double widthValue) {
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
              color: getColor(downhover),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  text1.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontSize: 40,
                      color: getColor(!downhover),
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  CupertinoIcons.chevron_down,
                  size: 60,
                  color: getColor(!downhover),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar alertScreenAppbar() {
    return AppBar(
      backgroundColor: AppColors.appbarColor2,
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const HomeScreen())));
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.iconColor,
        ),
      ),
      title: Center(child: changingText()),
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
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.appbarColor2,
            ))
      ],
    );
  }

  void tapHandler(String text) {
    if (text == "caretaker") {
      // callDoctorDialoug(
      //     "Are you sure you want to call the careTaker ?", doctorNo);
      FlutterPhoneDirectCaller.callNumber(caretakerNo);
    }
    if (text == "doctor") {
      // callDoctorDialoug(
      //     "Are you sure you want to call the doctor ?", caretakerNo);
      FlutterPhoneDirectCaller.callNumber(doctorNo);
    }
    if (text == "Return to home") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  Future<dynamic> callDoctorDialoug(String alertText, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppColors.boxBackground2,
              content: SizedBox(
                height: 200,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      alertText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 35,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(10),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                            child: Text(
                              "NO",
                              style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);

                                FlutterPhoneDirectCaller.callNumber(number);
                              });
                            },
                            style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(10),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                            child: Text(
                              "YES",
                              style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ));
        });
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
              FlutterPhoneDirectCaller.callNumber(caretakerNo);
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
              FlutterPhoneDirectCaller.callNumber(doctorNo);
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
