import 'package:esavings/model/savings.dart';
import 'package:esavings/shared/theme.dart';
import 'package:esavings/views/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreatePage extends StatefulWidget {
  final Box<Savings> savingsBox;
  const CreatePage(this.savingsBox);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late TextEditingController _controller;
  late Box<int> _balanceBox;

  @override
  void initState() {
    super.initState();
    _balanceBox = Hive.box<int>('balance');
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const CustomBackButton(),
                    const SizedBox(width: 15),
                    Text(
                      'Add New Savings',
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  'Enter the nominal you saved',
                  style: greyTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                formField(),
                const SizedBox(height: 20),
                saveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container formField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [defaultShadow],
      ),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: blackTextStyle.copyWith(
          fontSize: 17,
        ),
        decoration: InputDecoration(
          filled: true,
          prefixText: 'Rp',
          prefixStyle: blackTextStyle.copyWith(
            fontSize: 17,
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          
        },
      ),
    );
  }

  Widget saveButton(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(_controller.text.isNotEmpty){
          Savings savings = Savings(
            amount: int.parse(_controller.text),
            date: DateTime.now(),
          );
          widget.savingsBox.add(savings);
          _balanceBox.put(0, _balanceBox.get(0)! + savings.amount);
          _controller.clear();
          Navigator.pop(context);
          
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Oops'),
              titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              content: const Text('Please enter the nominal you saved'),
              contentTextStyle: blackTextStyle.copyWith(
                fontSize: 14,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [blueShadow],
        ),
        child: Center(
          child: Text(
            'Save',
            style: whiteTextStyle.copyWith(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

