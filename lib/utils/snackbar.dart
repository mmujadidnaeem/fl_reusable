part of '../../reusables.dart';

void showSnackbar(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);

  messenger
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}