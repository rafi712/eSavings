import 'package:esavings/model/savings.dart';
import 'package:esavings/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SavingsAdapter());

  await Hive.openBox<Savings>('savings');
  await Hive.openBox<int>('balance');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eSavings',
        onGenerateRoute: AppRouter.generateRoute,
      );
  }
}
