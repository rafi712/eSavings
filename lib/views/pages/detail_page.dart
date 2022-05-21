import 'package:esavings/model/savings.dart';
import 'package:esavings/shared/function.dart';
import 'package:esavings/shared/theme.dart';
import 'package:esavings/views/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final int index;
  final Box<Savings> savingsBox;
  final Box<int> balanceBox;

  const DetailPage(
    this.index,
    this.savingsBox,
    this.balanceBox,
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Savings savings = savingsBox.getAt(index)!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const CustomBackButton(),
              const SizedBox(height: 60),
              Text(
                '${savings.date.day} ${monthName(savings.date.month)} ${savings.date.year}',
                style: blackTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(savings.amount),
                style: greyTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [blueShadow],
                      ),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => deleteDialog(context, savings),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [redShadow],
                        ),
                        child: Center(
                          child: Text(
                            'Delete',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteDialog(BuildContext context, Savings savings) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Delete'),
      titleTextStyle: blackTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      contentTextStyle: blackTextStyle.copyWith(
        fontSize: 14,
      ),
      content: const Text('Are you sure you want to delete this balance?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            savingsBox.deleteAt(index);
            balanceBox.putAt(0, balanceBox.getAt(0)! - savings.amount);
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: redTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}