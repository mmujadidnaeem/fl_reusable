part of '../../fl_reusable.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();

  /// Checks if the navigator can pop the current route.
  static bool canPop() => navigatorKey.currentState!.canPop();

  /// Pushes a new route onto the navigator.
  static Future<dynamic> push(Widget page) async {
    return await navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Replaces the current route with a new route.
  static Future<dynamic> pushReplacement(Widget page) async {
    return await navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Pushes a new route and removes all the previous routes until the predicate returns true.
  static Future<dynamic> pushAndRemoveUntil(Widget page) async {
    return await navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
          (route) => false,
    );
  }

  /// Pops all routes until the predicate returns true.
  static void popAll() {
    return navigatorKey.currentState!.popUntil((route) => false);
  }

  /// Pops the current route with optional data.
  static void pop([dynamic data]) {
    navigatorKey.currentState!.pop(data);
  }

  /// Navigates to a new page.
  static Future<dynamic> to(Widget page) async {
    return await push(page);
  }

  /// Navigates to a new page and replaces the current one.
  static Future<dynamic> toReplace(Widget page) async {
    return await pushReplacement(page);
  }

  /// Navigates to a new page and removes all previous routes.
  static Future<dynamic> navigateRemoveUntil(Widget page) async {
    return await pushAndRemoveUntil(page);
  }

  /// Pushes a named route onto the navigator.
  static Future<dynamic> pushNamed(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  /// Replaces the current route with a named route.
  static Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pushes a named route and removes all the previous routes until the predicate returns true.
  static Future<dynamic> pushNamedAndRemoveUntil(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }
}