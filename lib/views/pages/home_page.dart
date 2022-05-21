import 'package:esavings/model/savings.dart';
import 'package:esavings/shared/function.dart';
import 'package:esavings/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Savings> _savingsBox;
  late Box<int> _balanceBox;

  Color backgroundColor(int index) {
    if(index.isEven) return redColor;
    return blueColor;
  }

  @override
  void initState() {
    super.initState();
    _savingsBox = Hive.box<Savings>('savings');
    _balanceBox = Hive.box<int>('balance');
    if (_balanceBox.values.toList().isEmpty) {
      _balanceBox.add(0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'eSavings',
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/balance', arguments: _balanceBox),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: blueColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Text('Savings History', style: greyTextStyle),
              ),
              const SizedBox(height: 20),
              savingsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create', arguments: _savingsBox),
        child: const Icon(Icons.add),
        backgroundColor: greenColor,
      ),
    );
  }

  Widget savingsList() {
    return ValueListenableBuilder(
      valueListenable: _savingsBox.listenable(),
      builder: (context, Box<Savings> box, _) {
        List<Savings> savings = box.values.toList().cast<Savings>();
        return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        clipBehavior: Clip.none,
        itemCount: savings.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/detail', arguments: {
            'index': index,
            'balanceBox': _balanceBox,
            'savingsBox': _savingsBox,
          }),
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(10),
            height: 85,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [defaultShadow]
            ),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: backgroundColor(savings[index].date.day),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [redShadow],
                  ),
                  child: Center(
                    child: Text(
                      savings[index].date.day.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        '${savings[index].date.day} ${monthName(savings[index].date.month)} ${savings[index].date.year}',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(savings[index].amount),
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}
