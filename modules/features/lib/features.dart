library features;

import 'package:features/beneficiary/add_page.dart';
import 'package:features/beneficiary/top_up_page.dart';
import 'package:features/home/home_page.dart';
import 'package:features/splash/splash_page.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  HomePage.routeName: (context) => HomePage(),
  AddBeneficiary.routeName: (context) => AddBeneficiary(),
  TopUpPage.routeName: (context) => TopUpPage(),
};