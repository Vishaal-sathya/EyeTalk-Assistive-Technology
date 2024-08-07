import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthome/components/constants.dart';
import 'package:smarthome/screens/home_screen_2.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _medicineTimeController = TextEditingController();

  List<String> recipents = [caretakerNo];
  String scheduleHour = "";
  String scheduleMin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MedicineScreenAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 90),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                return MedicineBox(medicine);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              // Arrange buttons horizontally
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AddMedicineButton(),
                RemoveMedicineButton(medicines), // Pass medicine list to button
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget AddMedicineButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context, // Pass the BuildContext of the widget
          builder: (BuildContext context) {
            // Return the content of the popup box

            return PopUp(context);
          },
        );
      },
      child: Container(
        // Your existing button container styling
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        decoration: BoxDecoration(
          // Your existing button decoration
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 237, 227, 208).withOpacity(0.5),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 10.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 144, 99, 2).withOpacity(0.5),
              offset: const Offset(6.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
          color: AppColors.boxBackground2,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          "Add Medicine",
          style: GoogleFonts.montserrat(
            fontSize: 35,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget RemoveMedicineButton(List<MedicineItem> medicines) {
    return GestureDetector(
      onTap: () {
        if (medicines.isNotEmpty) {
          setState(() {
            medicines.removeLast(); // Remove the last element
          });
        }
      },
      child: Container(
        // Your existing button container styling
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        decoration: BoxDecoration(
          // Your existing button decoration
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 237, 227, 208).withOpacity(0.5),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 10.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 144, 99, 2).withOpacity(0.5),
              offset: const Offset(6.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
          color: AppColors.boxBackground2,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          "Remove Medicine",
          style: GoogleFonts.montserrat(
            fontSize: 35,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  AlertDialog PopUp(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Medicine'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Add widgets for your popup content here
            // For example, a text field to enter medicine name:
            TextField(
              controller: _medicineNameController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
              ),
            ),
            TextField(
              controller: _medicineTimeController,
              decoration: const InputDecoration(
                labelText: 'Medicine Time',
              ),
            ),
            // More widgets for other details (dosage, instructions, etc.)
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () {
            // Get user input from controllers
            final medicineName = _medicineNameController.text;
            final medicineTime = _medicineTimeController.text;
            scheduleHour = medicineTime.substring(0, 2);
            scheduleMin = medicineTime.substring(medicineTime.length - 2);
            medicineTime.substring(medicineTime.length - 2);
            print(scheduleHour);
            print(scheduleMin);

            setState(() {
              medicines
                  .add(MedicineItem(name: medicineName, time: medicineTime));
            });
            scheduleEvent((int.parse(scheduleHour)), (int.parse(scheduleMin)));

            _medicineNameController.clear();
            _medicineTimeController.clear();

            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget MedicineBox(MedicineItem medicine) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 237, 227, 208).withOpacity(0.5),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 10.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 144, 99, 2).withOpacity(0.5),
              offset: const Offset(6.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
          color: AppColors.boxBackground2,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              medicine.name,
              style: GoogleFonts.montserrat(
                  fontSize: 40,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 16), // Add spacing between texts
            Text(
              medicine.time,
              style: GoogleFonts.montserrat(
                  fontSize: 40,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  AppBar MedicineScreenAppbar() {
    return AppBar(
      backgroundColor: AppColors.appbarColor2,
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen2()));
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
      title: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 98.0),
          child: Text(
            "Add Medicine",
            style: GoogleFonts.montserrat(
                fontSize: 40,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  void scheduleEvent(int targetHour, int targetMinute) {
    // Get the current time
    var now = DateTime.now();

    // Calculate the difference in milliseconds for the target time today
    var targetTimeToday =
        DateTime(now.year, now.month, now.day, targetHour, targetMinute);
    var differenceToday = targetTimeToday.difference(now).inMilliseconds;

    // Calculate the difference in milliseconds for the target time tomorrow
    var targetTimeTomorrow =
        DateTime(now.year, now.month, now.day + 1, targetHour, targetMinute);
    var differenceTomorrow = targetTimeTomorrow.difference(now).inMilliseconds;

    // Choose the smaller difference (considering today or tomorrow)
    var targetTimeMillis =
        differenceToday > 0 ? differenceToday : differenceTomorrow;

    // Create a Timer to check after the calculated difference
    Timer timer = Timer(Duration(milliseconds: targetTimeMillis), () {
      // Target time has arrived, trigger your event scheduling logic
      print("Event triggered!");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(medicines.last.name),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      ); // Replace with your scheduling logic

      // Optionally, reschedule for the next occurrence (consider edge cases)
      // ...
    });
  }
}
