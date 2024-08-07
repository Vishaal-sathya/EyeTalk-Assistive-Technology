import 'package:flutter/material.dart';

// class AppColors {
//   static Color appbarColor = const Color(0xFF1070BF);
//   static Color backgroundColor = const Color(0xff40a2d8);
//   static Color boxBackground = const Color(0xFFBAE3F8);
//   static Color suggestionBoxColor = const Color(0xFFC2E1EE);

//   static Color appbarColor2 = const Color(0xFFE67F0D); //used
//   static Color backgroundColor2 = const Color(0xFFFFAE03);
//   static Color boxBackground2 = const Color.fromARGB(255, 244, 240, 173); //used

//   static Color iconColor = const Color.fromARGB(255, 0, 0, 0);
//   static Color textColor = const Color(0xFF220901);
//   static Color buttonColor = const Color(0xff78daec);
// }

class AppColors {
  static Color appbarColor = const Color(0xFF1070BF);
  static Color backgroundColor = const Color(0xff40a2d8);
  static Color boxBackground = const Color(0xFFBAE3F8);
  static Color suggestionBoxColor = const Color(0xFFC2E1EE);

  static Color appbarColor2 = const Color(0xff006fab);
  static Color backgroundColor2 = const Color(0xFF00a6c7);
  static Color boxBackground2 = const Color(0xFFade8f4);

  static Color iconColor = const Color(0xff030457);
  static Color textColor = const Color(0xff030457);
  static Color buttonColor = const Color(0xff78daec);
}

String doctorNo = "+916380520414";
String caretakerNo = "";
String patientName = "xyz";

class Navigation {
  static int timerValue = 1000;
  static int counter = 0;
  static int delayDuration = 6;
}

class MedicineItem {
  final String name;
  final String time;

  const MedicineItem({required this.name, required this.time});
}

List<MedicineItem> medicines = [
  const MedicineItem(name: 'Paracetamol', time: '08:00'),
  const MedicineItem(name: 'Vitamin D', time: '21:00'),
];
