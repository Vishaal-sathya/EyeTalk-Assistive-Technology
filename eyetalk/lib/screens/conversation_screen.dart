// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:eyetalk/misc/constants.dart';
import 'package:eyetalk/firebase/firebase_service.dart';
import 'package:eyetalk/screens/home_screen.dart';
import 'package:eyetalk/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  //////////
  final FirebaseStringService _firebaseStringService = FirebaseStringService();
  FlutterTts flutterTts = FlutterTts();

  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String sttText = "";

  int startIndexLeft = 0;
  int startIndexRight = 4;
  int displayCount = 4;

  bool lefthover = false;
  bool righthover = false;
  bool downhover = false;

  bool PrevLefthover = false;
  bool PrevRighthover = false;
  bool PrevDownhover = false;

  int timerValue = 1000;
  Timer? _timer;

  late GenerativeModel model;
  List<String> suggestionList = [
    "Hi",
    "How are you",
    "Pardon",
    "i'm fine",
    "Pleased to meet you",
    "Could you help me",
    "Could you call the doctor",
    "Could you get my medicine",
    "I need some water",
    "I'm feeling good",
    "I'm feeling tired",
    "How's your family doing",
    "Long time no see",
    "How have you been",
    "Thank you so much",
    "I'm sorry to hear that",
    "I agree",
    "I disagree",
    "How was your day",
    "Take care",
    "Excuse me",
    "Nice to see you",
    "Much appreciated",
    "My condolences",
    "Be well",
    "Glad to make your acquaintance",
    "Take care of yourself",
    "Greetings",
    "Nice to see you again",
    "Much obliged",
    "How's the situation",
    "I'm Feeling drained",
  ];
  /////////////

  @override
  void initState() {
    super.initState();
    initSpeech();
    initModel();
    setUI();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed of
    super.dispose();
  }

  void initModel() async {
    model = GenerativeModel(
        model: "gemini-pro", apiKey: "AIzaSyCVFlS4KTOM4n_8kJHzlBIytnF3FpQjtRo");
    setState(() {});
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    sttText = "";
    await speechToText.listen(onResult: onSPeechResult);
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSPeechResult(result) {
    setState(() {
      sttText = "${result.recognizedWords}";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!speechToText.isListening && suggestionList.isEmpty) {
      generate(sttText);
    }
    return Scaffold(
      appBar: conversationScreenAppbar(),
      body: Stack(
        children: [
          // Container(
          //   decoration: const BoxDecoration(
          //       image: DecorationImage(
          //           fit: BoxFit.fill,
          //           image: AssetImage('assets/images/bg.png'))),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                speechToTextArea(),
                Divider(
                  color: AppColors.suggestionBoxColor,
                  thickness: 5,
                ),
                yourResponseBuilder(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Fixed size container for the left content
                        suggestionBoxBuilder(context, startIndexLeft, true),

                        VerticalDivider(
                          color: AppColors.suggestionBoxColor,
                          thickness: 5,
                        ),
                        // Fixed size container for the right content
                        suggestionBoxBuilder(context, startIndexRight, false),
                      ],
                    ),
                  ),
                ),
                micButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

/////////////   WIDGITS    /////////////

  AppBar conversationScreenAppbar() {
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
      title: Center(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: changingText()),
      ),
      actions: [
        // ElevatedButton(
        //     onPressed: () {
        //       tapHandler();
        //     },
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
                      builder: ((context) => const SettingsScreen())));
            },
            icon: Icon(
              Icons.settings,
              color: AppColors.iconColor,
            ))
      ],
    );
  }

  void tapHandler() {
    if (lefthover) {
      suggestionsTap(startIndexLeft, true);
    }
    if (righthover) {
      suggestionsTap(startIndexRight, false);
    }
    if (downhover) {
      micTapHandler();
    }
  }

  Widget micButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => downhover = true),
      onExit: (_) => setState(() => downhover = false),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            decoration: BoxDecoration(
                color: downhover
                    ? AppColors.textColor
                    : AppColors.suggestionBoxColor,
                borderRadius: BorderRadius.circular(20)),
            child: IconButton(
                onPressed: () {
                  micTapHandler();
                },
                icon: speechToText.isListening
                    ? Icon(
                        Icons.mic,
                        size: 30,
                        color: !downhover
                            ? AppColors.textColor
                            : AppColors.suggestionBoxColor,
                      )
                    : Icon(
                        Icons.mic_off,
                        size: 30,
                        color: !downhover
                            ? AppColors.textColor
                            : AppColors.suggestionBoxColor,
                      ))),
      ),
    );
  }

  void micTapHandler() {
    if (speechToText.isListening) {
      stopListening();
    } else {
      startListening();
      suggestionList.clear();
    }
  }

  Padding speechToTextArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
          child: SizedBox(
        height: 100,
        child: Center(
          child: Text(
            sttText,
            style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor),
          ),
        ),
      )),
    );
  }

  Widget yourResponseBuilder() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.boxBackground2),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.arrow_left_outlined,
              size: 45,
              color: AppColors.textColor,
            ),
            Text(
              "Your Response",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor),
            ),
            Icon(
              Icons.arrow_right_outlined,
              size: 45,
              color: AppColors.textColor,
            ),
          ],
        )),
      ),
    );
  }
////////////////////////////////////////////

  Widget suggestionBoxBuilder(
      BuildContext context, int startIndex, bool isLeft) {
    if (suggestionList.isNotEmpty) {
      final List<String> slicedSuggestions =
          suggestionList.sublist(startIndex, startIndex + displayCount);
      return GestureDetector(
        onTap: () {
          suggestionsTap(startIndex, isLeft);
        },
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: MediaQuery.of(context).size.width /
                2.1, // Adjust width as needed
            child: Column(
              children: slicedSuggestions.map((suggestion) {
                return suggestionBox(suggestion, isLeft);
              }).toList(),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void suggestionsTap(int startIndex, bool isLeft) {
    {
      if (displayCount == 4) {
        displayCount = 2;
      } else if (displayCount == 2) {
        displayCount = 1;
      } else if (displayCount == 1) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColors.suggestionBoxColor,
                content: Text(
                  suggestionList[startIndex],
                  style: GoogleFonts.montserrat(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              );
            });
        speak(suggestionList[startIndex]);

        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });

        startIndexLeft = 0;
        startIndexRight = 4;
        displayCount = 4;
      }
    }
    choose(isLeft);
  }

  Padding suggestionBox(String suggestion, bool isLeft) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: (suggestion.length + 10) * 10,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 10.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 10, 45, 53).withOpacity(0.5),
              offset: const Offset(6.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
          color: getColor((lefthover && isLeft) || (righthover && !isLeft)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            suggestion,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: getColor(
                    !((lefthover && isLeft) || (righthover && !isLeft)))),
          ),
        ),
      ),
    );
  }

  void refreshSuggestions() {
    setState(() {
      startIndexLeft += 8;
      startIndexRight += 8;

      if (startIndexLeft + 4 >= suggestionList.length) {
        startIndexLeft = 0;
      }
      if (startIndexRight + 4 >= suggestionList.length) {
        startIndexRight = 4;
      }
    });
  }

  void choose(bool isLeft) {
    if (isLeft) {
      startIndexRight = startIndexLeft + displayCount;
    } else {
      startIndexLeft = startIndexRight + displayCount;
    }
  }

  speak(String ttsText) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(ttsText);
  }

  void generate(String phrase) async {
    int responseCount = 30;

    String promptText =
        "this is an app for paralysed people who cant speak and you are their supportive ai who will generate $responseCount resposnse to the given phrase \"$phrase\".You must always give $responseCount responses, never more, never less. since you will help the patient to converse you have to create responses from the patients point of view. the name of the patient is \"$patientName\". i want the responses to be seperated by a single *.The text you generate should be of the format \"response 1*response 2*\" and so on, it should only contain the responses and the separating * nothing else. dont generate anything but the responses. the responses should not be long. keep in mind that the person you are talking to already knows the patient is paralysed, you dont need to bring it up often";

    final prompt = [Content.text(promptText)];
    final response = await model.generateContent(prompt);

    // Split the output into individual phrases, handling potential empty lines
    final phrases =
        response.text?.split('*').where((line) => line.isNotEmpty).toList();

    suggestionList.addAll(phrases?.sublist(0, 20) ?? []);
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
              suggestionsTap(startIndexLeft, true);
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
              suggestionsTap(startIndexRight, false);
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
              micTapHandler();
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
