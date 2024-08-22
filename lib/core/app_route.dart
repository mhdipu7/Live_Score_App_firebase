import 'package:go_router/go_router.dart';
import 'package:live_football_score/view/screens/home_screen.dart';
import 'package:live_football_score/view/screens/notification_screen.dart';

class AppRoute {
  ///------Route paths------///
  static const String _homeScreenPath = "/home_screen";
  static const String _notificationScreenPath = "/notification_screen";

  ///------Route name------///
  static const String homeScreen = "home";
  static const String notificationScreen = "notification";

  static final router = GoRouter(
    initialLocation: _homeScreenPath,
    routes: [
      GoRoute(
        name: homeScreen,
        path: _homeScreenPath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: notificationScreen,
        path: _notificationScreenPath,
        builder: (context, state) => const NotificationScreen(),
      ),
    ],
  );
}
