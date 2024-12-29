part of '../../fl_reusable.dart';



class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}



/// How to hide the keyboard.
///
/// import 'package:keyboard_hider/keyboard_hider.dart';
///
//
// class YourWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // When you now tap on the child, the keyboard should be dismissed.
//     return KeyboardHider(
//       child: Text('your widgets...'),
//     );
//   }
// }

//

// class YourOtherWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // When you now tap on the child, the keyboard should be hidden.
//     return KeyboardHider(
//       mode: HideMode.hideTextInput,
//       child: Text('your widgets...'),
//     );
//   }
// }

enum HideMode {
  /// Uses the context's [FocusScopeNode]'s (by calling the [FocusScope.of])
  /// unfocus method.
  ///
  /// It causes the [KeyboardHider] widget to call `unfocus` function on tap.
  unfocus,

  /// Uses the textInput channel used by the Flutter system, and invokes
  /// 'TextInput.hide' on it.
  ///
  /// It causes the [KeyboardHider] widget to call [hideTextInput] on tap.
  hideTextInput,
}

/// A widget that upon tap attempts to hide the keyboard.
class KeyboardHider extends StatelessWidget {
  /// Creates a widget that on tap, hides the keyboard.
  const KeyboardHider({
    required this.child,
    this.mode = HideMode.unfocus,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// How the widget should hide the keyboard.
  ///
  /// By default, [HideMode.unfocus] is used.
  final HideMode mode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        switch (mode) {
          case HideMode.unfocus:
            return unfocus(context);
          case HideMode.hideTextInput:
            return hideTextInput();
        }
      },
      child: child,
    );
  }
}

/// Hide keyboard by un-focusing the current context's [FocusScopeNode].
///
/// Used by the [KeyboardHider] widget if the hide mode is set to
/// [HideMode.unfocus] (default behavior).
void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

/// Hide keyboard by invoking the "TextInput.hide" method on
/// [SystemChannels.textInput].
///
/// Used by the [KeyboardHider] widget if the hide mode is set to
/// [HideMode.hideTextInput].
///
/// This function hides the keyboard, but it will not unfocus the
/// focus scope node, so if a text field was in focus, it will stay highlighted.
Future<void> hideTextInput() => textInput.invokeMethod('TextInput.hide');

// The  following getters, setters are only needed for unit testing.
MethodChannel? _textInput;

@visibleForTesting
MethodChannel get textInput => _textInput ?? SystemChannels.textInput;

@visibleForTesting
set textInput(MethodChannel? v) => _textInput = v;