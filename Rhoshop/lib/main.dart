import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/screens/all.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;

void main() {
  runApp(RhoshopApp());
}

class RhoshopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalization.of(context).appTitle,
      localizationsDelegates: [
        const AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ru', ''),
      ],
      locale: Locale('en'),
      routes: {
        '/': (context) => IntroScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen()
      },
      theme: ThemeData(
        primaryColor: AppColors.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            headline1: TextStyle(
              color: AppColors.primaryText,
              fontSize: 46,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
            headline3: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
            subtitle2: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
            button: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 20,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
