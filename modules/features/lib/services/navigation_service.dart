import 'package:features/beneficiary/add_page.dart';
import 'package:features/beneficiary/top_up_page.dart';
import 'package:features/home/home_page.dart';
import 'package:features/splash/splash_page.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  Future<Object?> navigateTo(String routeName,
      {bool clearBackStack = false}) async {
    Object? _pop;
    if (clearBackStack) {
      _pop = await navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('routeName', (route) => false);
    } else {
      _pop = await navigatorKey.currentState?.pushNamed(routeName);
    }

    return _pop;
  }

  static void goback() {
    return navigatorKey.currentState!.pop();
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  HomePage.routeName: (context) => HomePage(),
  AddBeneficiary.routeName: (context) => AddBeneficiary(),
  TopUpPage.routeName: (context) => TopUpPage(),
};
