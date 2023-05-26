import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/utils/dimensions.dart';
import 'package:todoapp/utils/text.dart';

import '../services/db_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime currentDate = DateTime.now();
  String date = "Select the date";

  DBServices services = DBServices();

  bool titleText = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2030));
    if (picked != null && picked != currentDate) {
      final pickedDate = DateFormat('dd, MMMM yyyy').format(picked);
      setState(() {
        currentDate = picked;
        date = pickedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0077b6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const AppText(
          text: "Add new thing",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.screenWidth * 0.03,
              vertical: Dimensions.screenHeight * 0.15),
          child: Column(
            children: [
              const Icon(
                Icons.add_task_rounded,
                size: 70,
                color: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: title,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  fillColor: AppColors.tabOne,
                  errorText: titleText ? "Enter the title" : null,
                  label: const AppText(
                    text: "Title",
                    fontSize: 15,
                    fontColor: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: description,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    label: AppText(
                      text: "Description",
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    AppText(
                      text: date,
                      fontSize: 10,
                      fontColor: AppColors.white,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Dimensions.screenWidth * 0.7,
                height: Dimensions.screenHeight * 0.07,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff73d2de)),
                    onPressed: () {
                      if (title.text.isEmpty) {
                        setState(() {
                          titleText = true;
                        });
                      } else {
                        services.addTask(title.text, description.text, date);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const AppText(
                      text: "ADD YOUR THING",
                      fontSize: 15,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
