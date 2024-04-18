part of '../../reusables.dart';

abstract class AppNavigationMaterial {
  static Future<dynamic> to(
    BuildContext context,
    Widget page,
  ) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static Future<dynamic> pop(
    BuildContext context,
  ) async {
    return Navigator.of(context).pop();
  }

  static Future<dynamic> toReplace(
    BuildContext context,
    Widget page,
  ) async {
    return await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static navigateRemoveUntil(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext con) => page,
      ),
      (route) => false,
    );
  }
}
