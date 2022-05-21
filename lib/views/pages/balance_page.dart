import 'package:esavings/shared/theme.dart';
import 'package:esavings/views/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class BalancePage extends StatelessWidget {
  final Box<int> balanceBox;
  const BalancePage(this.balanceBox);

  @override
  Widget build(BuildContext context) {
    int totalBalance = balanceBox.values.first;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const CustomBackButton(),
              const SizedBox(height: 60),
              Text(
                'Total Balance',
                style: greyTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(totalBalance),
                style: blackTextStyle.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
