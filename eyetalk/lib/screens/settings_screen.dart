import 'package:eyetalk/misc/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String doctorContactNo = "";
  TextEditingController doctorNumberText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController caretakerNumberText = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    doctorNumberText.dispose();
    nameText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: settingsAppbar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bg.png'))),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textFieldBuilder(context, "Enter doctor's number",
                    doctorNumberText, CupertinoIcons.heart_fill),
                buttonBuilder("Set doctor's number", "set dr no."),
                textFieldBuilder(context, "Enter caretakers's number",
                    caretakerNumberText, CupertinoIcons.person_fill),
                buttonBuilder("Set caretaker's number", "set ct no."),
                textFieldBuilder(
                    context, "enter your name", nameText, Icons.person),
                buttonBuilder("Set your name", "set name")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding textFieldBuilder(BuildContext context, String hintText,
      TextEditingController controller, IconData iconData) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width / 3),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            prefixIcon: Icon(
              iconData,
              size: 30,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 30),
            border: InputBorder.none,
            fillColor: Colors.black),
      ),
    );
  }

  AppBar settingsAppbar() {
    return AppBar(
      backgroundColor: AppColors.appbarColor,
      title: Center(
        child: Text(
          "Settings",
          style: GoogleFonts.inconsolata(
              fontSize: 30,
              color: const Color.fromARGB(255, 224, 231, 240),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  ElevatedButton buttonBuilder(String text, String function) {
    return ElevatedButton(
      onPressed: () {
        if (function == "set dr no.") {
          setState(() {
            doctorNo = doctorNumberText.text;
          });
        }
        if (function == "set ct no.") {
          setState(() {
            caretakerNo = caretakerNumberText.text;
          });
        }
        if (function == "set name") {
          setState(() {
            patientName = nameText.text;
          });
        }
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.appbarColor),
          shadowColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 0, 0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          text,
          style: GoogleFonts.inconsolata(
              fontSize: 25,
              color: const Color.fromARGB(255, 224, 231, 240),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
