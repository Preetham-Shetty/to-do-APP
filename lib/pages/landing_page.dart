import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/services/db_services.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/utils/dimensions.dart';
import 'package:todoapp/utils/text.dart';
import 'package:todoapp/widgets/add_task_dialog.dart';
import 'package:todoapp/widgets/logout_button.dart';
import 'package:todoapp/widgets/recent_tabs.dart';
import 'package:todoapp/widgets/tasks_list.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DateTime currentDate = DateTime.now();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    String displayDate = DateFormat.yMMMMd().format(currentDate);
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: AppColors.tabOne,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTaskDialog();
              });
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensions.screenHeight * 0.02),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: NetworkImage(user.photoURL!))),
              ),
              SizedBox(
                height: Dimensions.screenHeight * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.screenWidth * 0.04),
                child: AppText(
                  text: user.email!,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProximaNova',
                  fontAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const LogoutButton()
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.black),
        title: AppText(
          text: displayDate,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontColor: AppColors.black,
          fontFamily: 'ProximaNova',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: DBServices().addTaskStream(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset('assets/lottie/add_task.json',
                        height: 200, width: 200),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppText(
                      text: "No tasks to show!",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.screenWidth * 0.03,
                      vertical: Dimensions.screenHeight * 0.01),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          text: "Tasks Summary",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.black,
                          fontFamily: 'ProximaNova',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            RecentTabs(
                              color: AppColors.tabOne,
                              title: 'Total Tasks',
                              shadowColor: AppColors.tabOnehadow,
                              tabOne: true,
                            ),
                            RecentTabs(
                                color: AppColors.tabTwo,
                                title: 'Completed',
                                shadowColor: Colors.transparent,
                                tabOne: false)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const AppText(
                          text: "All Tasks",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.black,
                          fontFamily: 'ProximaNova',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const TaskList()
                      ])),
            );
          }),
    );
  }
}
