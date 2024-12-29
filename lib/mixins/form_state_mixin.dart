part of '../../reusables.dart';


/// A mixin to ease the use of [Form] in a [StatefulWidget].
///
/// This mixin provides a [formKey] to be used with a [Form] widget and a [submitter]
/// method to handle form submission. It also includes an [autovalidateMode] to control
/// the form's validation behavior.
mixin FormStateMixin<T extends StatefulWidget> on State<T> {
  /// A [GlobalKey] to be used with the [Form] widget.
  final formKey = GlobalKey<FormState>();

  /// Controls the auto-validation mode of the form.
  var autovalidateMode = AutovalidateMode.disabled;

  /// A function to be used as the form's submit button handler.
  ///
  /// This function validates the form fields, saves their values, and calls the
  /// [onSubmit] method if the form is valid. If the form is not valid, it enables
  /// auto-validation and updates the state.
  ///
  /// Example usage:
  /// ```dart
  /// TextButton(
  ///   child: Text('Submit'),
  ///   onPressed: submitter,
  /// )
  /// ```
  void submitter() {
    // Validate the form fields.
    if (!formKey.currentState!.validate()) {
      // Enable auto-validation if the form is not valid.
      autovalidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    // Save the form field values.
    formKey.currentState?.save();

    // Call the user-defined onSubmit method.
    onSubmit();
  }

  /// A method to be overridden by the user to handle form submission.
  ///
  /// This method is called by [submitter] once the form is validated and saved.
  /// The user must provide an implementation for this method to define the form
  /// submission behavior.
  FutureOr<void> onSubmit();

  /// Resets the form to its initial state.
  void resetForm() {
    formKey.currentState?.reset();
    autovalidateMode = AutovalidateMode.disabled;
    setState(() {});
  }

  /// Checks if the form is valid without saving the field values.
  bool isFormValid() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Saves the form field values without validating them.
  void saveForm() {
    formKey.currentState?.save();
  }


  /// Moves to the next form field when the enter key is pressed.
  void moveToNextField(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.nextFocus();
    }
  }

  /// A function to be used as the form's submit button handler with control over moving to the next field.
  ///
  /// This function validates the form fields, saves their values, and calls the
  /// [onSubmit] method if the form is valid. If the form is not valid, it enables
  /// auto-validation and updates the state. It also moves to the next field if specified.
  ///
  /// Example usage:
  /// ```dart
  /// TextButton(
  ///   child: Text('Submit'),
  ///   onPressed: () => submitterWithNextField(context, moveToNext: true),
  /// )
  /// ```
  void submitterWithNextField(BuildContext context, {bool moveToNext = false}) {
    // Validate the form fields.
    if (!formKey.currentState!.validate()) {
      // Enable auto-validation if the form is not valid.
      autovalidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    // Save the form field values.
    formKey.currentState?.save();

    // Move to the next field if specified.
    if (moveToNext) {
      moveToNextField(context);
    }

    // Call the user-defined onSubmit method.
    onSubmit();
  }
}