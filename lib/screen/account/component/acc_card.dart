// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/component/card_user.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import '../../../controller/getacc_controller.dart';
import '../../../model/respon_accuser.dart';
import '../../Menuitem/qrpay/pay.dart';

class AccCard extends StatefulWidget {
  const AccCard({super.key});

  @override
  State<AccCard> createState() => _AccCardState();
}

class _AccCardState extends State<AccCard> {
  AccController accController = AccController();

  @override
  Widget build(BuildContext context) {
    // final thaiBahtFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');
    // final formattedDate = DateFormat("dd-MM-yyyy");

    // String formatCurrency(double amount) {
    //   final formatter = NumberFormat("#,###.00", "th");
    //   return formatter.format(amount);
    // }

    return FutureBuilder(
      future: accController.fetchAccData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox.shrink(),
            // child: CircularProgressIndicator(
            //   color: Colors.teal.shade500,
            // ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: SizedBox.shrink(),
            // child: CircularProgressIndicator(
            //   color: Colors.teal.shade500,
            // ),
          );
        }

        final _model = snapshot.data as UserAccModel;

        return ListView(
          physics: const BouncingScrollPhysics(),
          children: _model.data!.map((data) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                child: CardUser(
                  data: data,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Payment(),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
