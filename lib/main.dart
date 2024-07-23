import 'package:core/blocs/top_up/top_up_cubit.dart';
import 'package:core/blocs/user_details/user_detail_cubit.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await setUpLocator();
  _initFimber();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        //Provide In-App memory
        BlocProvider(create: (context) => inject<UserDetailCubit>()),
        BlocProvider(
            create: (context) =>
            inject<TopUpCubit>()..simulateInitilizingUser())
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
