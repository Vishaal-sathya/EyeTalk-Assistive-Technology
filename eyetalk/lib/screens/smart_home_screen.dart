import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthome/components/constants.dart';
import 'package:smarthome/firebase/firebase_services.dart';
import 'package:smarthome/screens/settings_screen.dart';
import 'package:smarthome/screens/smart_home_2.dart';

void main() async {}

class SmartHome extends StatefulWidget {
  const SmartHome({super.key});

  @override
  State<SmartHome> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SmartHome> {
  final FirebaseStringService _firebaseStringService = FirebaseStringService();
  bool lefthover = false;
  bool righthover = false;
  bool downhover = false;

  bool PrevLefthover = false;
  bool PrevRighthover = false;
  bool PrevDownhover = false;

  bool leftSwitch = false;
  bool rightSwitch = false;

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
        appBar: SmartAppbar1(),
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      LeftButtonBuilder(
                          lefthover,
                          "Turn on",
                          "Light 1",
                          CupertinoIcons.lightbulb_fill,
                          MediaQuery.of(context).size.height / 1.8,
                          MediaQuery.of(context).size.width / 2.12),
                      RightButtonBuilder(
                        righthover,
                        "Turn on",
                        "Fan 1",
                        Icons.mode_fan_off,
                        MediaQuery.of(context).size.height / 1.8,
                        MediaQuery.of(context).size.width / 2.12,
                      )
                    ],
                  ),
                  smallButtonBuilder(
                      downhover,
                      "More Options",
                      Icons.more_horiz,
                      MediaQuery.of(context).size.height / 4.2,
                      MediaQuery.of(context).size.width)
                ],
              )),
        ]));
  }

  Widget LeftButtonBuilder(
    bool hover,
    String text1,
    String text2,
    IconData icondata1,
    double heightValue,
    double widthValue,
  ) {
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
              padding: const EdgeInsets.all(70.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        icondata1,
                        size: 110,
                        color: getColor(!(hover)),
                      ),
                      Transform.scale(
                        scale: 2.2,
                        child: Switch(
                          value: leftSwitch,
                          activeColor: Colors.red[800],
                          onChanged: (bool value) {
                            setState(() {
                              leftSwitch = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Column(
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
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget RightButtonBuilder(
    bool hover,
    String text1,
    String text2,
    IconData icondata1,
    double heightValue,
    double widthValue,
  ) {
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
              padding: const EdgeInsets.all(70.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        icondata1,
                        size: 110,
                        color: getColor(!(hover)),
                      ),
                      Transform.scale(
                        scale: 2.2,
                        child: Switch(
                          value: rightSwitch,
                          activeColor: Colors.red[800],
                          onChanged: (bool value) {
                            setState(() {
                              rightSwitch = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Column(
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
                    ],
                  )
                ],
              )),
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

  void tapHandler(String text) {
    if (text == "Light 1") {
      leftSwitch = !leftSwitch;
    }
    if (text == "Fan 1") {
      rightSwitch = !rightSwitch;
    }
    if (text == "More Options") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SmartHome2()));
    }
  }

  AppBar SmartAppbar1() {
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
              leftSwitch = !leftSwitch;
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
              rightSwitch = !rightSwitch;
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
                  MaterialPageRoute(builder: (context) => const SmartHome2()));
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
