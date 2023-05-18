import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/services/db_services.dart';

import '../utils/colors.dart';
import '../utils/text.dart';

class EditTaskDialog extends StatefulWidget {
  final String editTitle;
  final String editDesc;
  final bool edit;
  final bool completed;
  String date;
  EditTaskDialog(
      {required this.editTitle,
      required this.editDesc,
      required this.edit,
      required this.date,
      required this.completed,
      super.key});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  DBServices services = DBServices();

  TextEditingController titleEdit = TextEditingController();
  TextEditingController descEdit = TextEditingController();

  DateTime currentDate = DateTime.now();
  String showDate = "";

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
        showDate = pickedDate;
        widget.date = showDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    titleEdit.text = widget.editTitle;
    descEdit.text = widget.editDesc;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          AppText(
            text: widget.edit ? "Edit Your Task" : "Your Task",
            fontSize: 15,
            fontFamily: 'ProximaNova',
            fontWeight: FontWeight.bold,
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
      content: widget.edit
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleEdit,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: AppText(text: 'Title', fontSize: 15)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descEdit,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: AppText(text: 'Description', fontSize: 15)),
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
                        text: widget.date,
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tabOne),
                    onPressed: () {
                      services.updateTask(widget.editTitle, titleEdit.text,
                          descEdit.text, widget.date);
                      Navigator.of(context).pop();
                    },
                    child: const AppText(
                      text: "Edit",
                      fontSize: 15,
                      fontFamily: 'ProximaNova',
                      fontColor: AppColors.white,
                    ))
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.editTitle,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  text: widget.editDesc,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  text: widget.date,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!widget.completed)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tabOne),
                        onPressed: () {
                          services.completeTask(widget.editTitle);
                          Navigator.of(context).pop();
                        },
                        child: const AppText(
                          text: "Complete",
                          fontSize: 15,
                          fontFamily: 'ProximaNova',
                          fontColor: AppColors.white,
                        )),
                  )
              ],
            ),
    );
  }
}
