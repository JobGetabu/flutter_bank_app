import 'package:core/services/navigation_service.dart';
import 'package:core/utils/bloc_observer.dart';
import 'package:core/utils/view_utils.dart';
import 'package:core/di/injector.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/features.dart';
import 'package:features/splash/splash_page.dart';
import 'package:flutter/material.dart';

void _initFimber() {
  Fimber.plantTree(DebugTree(useColors: true));
}

void _initBlocObserver() {
  BlocOverrides.runZoned(
    () async {

      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await setUpLocator();
  _initFimber();
  //_initBlocObserver();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        setUpScreenUtil(context);
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: widget!,
        );
      },
      title: 'Bank App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: SplashPage.routeName,
      routes: routes,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme
        )
      ),
    );
  }
}
