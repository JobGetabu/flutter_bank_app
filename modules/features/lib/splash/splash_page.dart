import 'package:dependencies/dependencies.dart';
import 'package:features/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'SplashPage';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with AfterLayoutMixin<SplashPage> {
  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () async {
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
            child: Container(
      width: size.width * 0.7,
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/images/logo.png",
        height: 100.h,
      ),
    )));
  }
}
