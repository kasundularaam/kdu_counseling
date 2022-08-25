import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/exceptions/route_exception.dart';
import '../../data/models/app_user.dart';
import '../../logic/cubit/landing_cubit/landing_cubit.dart';
import '../../logic/cubit/login_cubit/login_cubit.dart';
import '../../logic/cubit/sessions_cubit/sessions_cubit.dart';
import '../screens/auth/login_screen/login_page.dart';
import '../screens/chat_screen/chat_page.dart';
import '../screens/home_screen/home_page.dart';
import '../screens/landing_screen/landing_page.dart';

class AppRouter {
  static const String landingPage = '/';
  static const String homePage = '/homePage';
  static const String loginPage = '/loginPage';
  static const String chatPage = '/chatPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LandingCubit(),
            child: const LandingPage(),
          ),
        );
      case homePage:
        final AppUser appUser = settings.arguments as AppUser;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SessionsCubit(),
            child: HomePage(
              appUser: appUser,
            ),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );

      case chatPage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChatPage(
            appUser: args["appUser"],
            session: args["session"],
          ),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
