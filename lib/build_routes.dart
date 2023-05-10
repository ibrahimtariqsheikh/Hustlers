import 'package:flutter/cupertino.dart';
import 'package:synew_gym/pages/auth_landing.dart';

import 'package:synew_gym/pages/create_page.dart';
import 'package:synew_gym/pages/nutrition_page.dart';
import 'package:synew_gym/pages/create_new_workout.dart';
import 'package:synew_gym/pages/signin_page.dart';
import 'package:synew_gym/pages/signup_page.dart';
import 'package:synew_gym/pages/tab_bar_page.dart';

Route<dynamic> buildRoutes(RouteSettings settings) {
  WidgetBuilder builder;
  switch (settings.name) {
    case SignUpPage.routeName:
      builder = (BuildContext _) => const SignUpPage();
      break;
    case SignInPage.routeName:
      builder = (BuildContext _) => const SignInPage();
      break;
    case NutritionPage.routeName:
      builder = (BuildContext _) => const NutritionPage();
      break;
    case CreatePage.routeName:
      builder = (BuildContext _) => const CreatePage();
      break;
    case AuthLanding.routeName:
      builder = (BuildContext _) => const AuthLanding();
      break;
    case CreateNewWorkout.routeName:
      builder = (BuildContext _) => const CreateNewWorkout();
      break;
    case TabBarPage.routeName:
      builder = (BuildContext _) => const TabBarPage();
      break;
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  return CupertinoPageRoute(builder: builder, settings: settings);
}
