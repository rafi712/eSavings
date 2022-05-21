import 'package:hive/hive.dart';

part 'savings.g.dart';

@HiveType(typeId: 0)
class Savings {
  @HiveField(0)
  final int amount;
  
  @HiveField(1)
  final DateTime date;
  
  Savings({
    required this.amount,
    required this.date,
  });

  Savings copyWith({
    int? amount,
    DateTime? date,
  }) {
    return Savings(
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
