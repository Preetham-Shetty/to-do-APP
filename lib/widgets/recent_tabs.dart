import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/services/db_services.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/utils/dimensions.dart';
import 'package:todoapp/utils/text.dart';

class RecentTabs extends StatelessWidget {
  final bool tabOne;
  const RecentTabs({
    required this.tabOne,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DBServices().addTaskStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          int completeCount = 0;
          for (QueryDocumentSnapshot document in snapshot.data!.docs) {
            Map<String, dynamic> documentData =
                document.data() as Map<String, dynamic>;
            if (documentData['completed'] == true) {
              completeCount++;
            }
          }
          return Column(
            children: [
              AppText(
                text: tabOne
                    ? snapshot.data.docs!.length.toString()
                    : completeCount.toString(),
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              AppText(
                text: tabOne ? "Completd" : "Pending",
                fontSize: 12,
                fontColor: AppColors.white,
              )
            ],
          );
          // Container(
          //   width: Dimensions.screenWidth * 0.45,
          //   padding: EdgeInsets.symmetric(
          //       horizontal: Dimensions.screenWidth * 0.03,
          //       vertical: Dimensions.screenHeight * 0.01),
          //   decoration: BoxDecoration(
          //       color: color,
          //       borderRadius: const BorderRadius.all(Radius.circular(20)),
          //       boxShadow: [
          //         BoxShadow(
          //             offset: const Offset(5, 6),
          //             color: shadowColor,
          //             blurRadius: 10)
          //       ]),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Icon(
          //         tabOne
          //             ? Icons.all_inclusive_rounded
          //             : Icons.add_task_outlined,
          //         color: AppColors.white,
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Row(
          //         children: [
          //           Flexible(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 AppText(
          //                   text: title,
          //                   fontSize: 20,
          //                   fontColor: AppColors.white,
          //                   fontWeight: FontWeight.bold,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //                 const SizedBox(
          //                   height: 10,
          //                 ),
          //                 AppText(
          //                   text: tabOne
          //                       ? snapshot.data.docs!.length.toString()
          //                       : completeCount.toString(),
          //                   fontSize: 30,
          //                   fontColor: AppColors.white,
          //                   fontWeight: FontWeight.bold,
          //                 )
          //               ],
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // );
        });
  }
}
