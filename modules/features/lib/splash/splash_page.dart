import 'package:dependencies/dependencies.dart';
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
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                Container(
                      width: size.width * 0.7,
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 100.h,
                      ),
                    ),
              ],
            )));
  }
}
