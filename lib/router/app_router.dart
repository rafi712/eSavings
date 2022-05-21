import 'package:esavings/model/savings.dart';
import 'package:esavings/views/pages/balance_page.dart';
import 'package:esavings/views/pages/create_page.dart';
import 'package:esavings/views/pages/detail_page.dart';
import 'package:esavings/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case '/balance':
        return MaterialPageRoute(builder: (context) => BalancePage(
          settings.arguments as Box<int>,
        ));
      case '/detail':
        return MaterialPageRoute(builder: (context) => DetailPage(
          (settings.arguments as Map)['index'] as int,
          (settings.arguments as Map)['savingsBox'] as Box<Savings>,
          (settings.arguments as Map)['balanceBox'] as Box<int>,
        ));
      case '/create':
        return MaterialPageRoute(builder: (context) =>  CreatePage(
          settings.arguments as Box<Savings>,
        ));
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}