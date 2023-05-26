import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/services/db_services.dart';
import 'package:todoapp/widgets/edit_task_dialog.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/text.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  DBServices services = DBServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: services.addTaskStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: EdgeInsets.only(bottom: Dimensions.screenHeight * 0.1),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            right: Dimensions.screenWidth * 0.02,
                            top: Dimensions.screenHeight * 0.01,
                            bottom: Dimensions.screenHeight * 0.01),
                        margin: EdgeInsets.only(
                            top: Dimensions.screenHeight * 0.03),
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(3, 4),
                                  blurRadius: 5.0,
                                  color: AppColors.shadowBlack)
                            ]),
                        child: Row(children: [
                          Container(
                            width: 5,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: data['completed']
                                  ? Colors.green
                                  : AppColors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: data['title'],
                                  fontSize: 15,
                                  fontColor: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppText(
                                  text: data['description'],
                                  fontSize: 12,
                                  fontColor: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                  // maxline: 2,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/clock.svg',
                                      height: 15,
                                      width: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText(
                                      text: data['date'] == ""
                                          ? "No end time"
                                          : data['date'],
                                      fontSize: 8,
                                      fontColor: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    AppText(
                                      text:
                                          ' | ${data['completed'] ? 'Completed' : 'Pending'}',
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.grey,
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditTaskDialog(
                                                editDesc: data['description'],
                                                editTitle: data['title'],
                                                edit: false,
                                                date: data['date'],
                                                completed: data['completed'],
                                              );
                                            });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.screenWidth * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: data['completed']
                                                    ? Colors.green
                                                    : AppColors.red),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: AppText(
                                          text: "View",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontColor: data['completed']
                                              ? Colors.green
                                              : AppColors.red,
                                          fontFamily: 'ProximaNova',
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Positioned(
                        top: 15,
                        child: Row(
                          children: [
                            if (!data['completed'])
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(3, 4),
                                          blurRadius: 5.0,
                                          color: AppColors.shadowBlack)
                                    ]),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditTaskDialog(
                                              editDesc: data['description'],
                                              editTitle: data['title'],
                                              edit: true,
                                              date: data['date'],
                                              completed: data['completed']);
                                        });
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColors.blue,
                                    size: 20,
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(3, 4),
                                        blurRadius: 5.0,
                                        color: AppColors.shadowBlack)
                                  ]),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const AppText(
                                            text:
                                                "Are you sure you want to delete",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.black,
                                          ),
                                          content: Row(children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.tabOne),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const AppText(
                                                  text: "Cancel",
                                                  fontSize: 15,
                                                  fontColor: AppColors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.red),
                                                onPressed: () {
                                                  services.deleteTask(
                                                      data['title']);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const AppText(
                                                  text: "Delete",
                                                  fontSize: 15,
                                                  fontColor: AppColors.white,
                                                  fontWeight: FontWeight.bold,
                                                ))
                                          ]),
                                        );
                                      });
                                },
                                child: const Icon(
                                  Icons.delete_rounded,
                                  color: AppColors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
          );
        });
  }
}
