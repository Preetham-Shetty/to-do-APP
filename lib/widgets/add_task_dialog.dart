import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/services/db_services.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/utils/text.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
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
    return AlertDialog(
      title: Row(
        children: [
          const AppText(
            text: "Add your task",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'ProximaNova',
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close,
              color: AppColors.red,
            ),
          )
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: title,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                fillColor: AppColors.tabOne,
                errorText: titleText ? "Enter the title" : null,
                label: const AppText(
                  text: "Title",
                  fontSize: 15,
                ),
                border: const OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: description,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 3,
            decoration: const InputDecoration(
                label: AppText(
                  text: "Description",
                  fontSize: 15,
                ),
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
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
                  fontColor: AppColors.grey,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.tabOne),
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
                text: "Add Task",
                fontSize: 15,
                fontFamily: 'ProximaNova',
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
