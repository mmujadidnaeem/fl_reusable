part of '../../fl_reusable.dart';

/// An abstract class that provides a mechanism to handle asynchronous operations
/// with custom behaviors before and after the operation.
abstract class AsyncTaskHandler {

  /// Sets the default [AsyncTaskBehaviour] to be used if no specific behavior is provided.
  static set defaultBehaviour(AsyncTaskBehaviour behaviour) => _default = behaviour;

  /// Executes the provided asynchronous operation [future] with the specified [behaviour].
  ///
  /// The [arguments] parameter can be used to pass optional arguments to the behavior.
  /// The [context] parameter is required to provide the [BuildContext] for the operation.
  ///
  /// Throws an exception if no [AsyncTaskBehaviour] is specified.
  static Future<T> process<T, U>({
    U? arguments,
    required Future<T> future,
    AsyncTaskBehaviour? behaviour,
    required BuildContext context,
  }) async {
    behaviour ??= _default;
    if (behaviour == null) {
      throw 'No [AsyncTaskBehaviour] was specified, either pass a '
          '[AsyncTaskBehaviour] to `behaviour` parameter or use '
          '[defaultBehaviour] setter to set a default [AsyncTaskBehaviour]';
    }

    // Capture necessary information from the context before the async operation
    final capturedContext = context;

    await behaviour.before(capturedContext, arguments);
    T result;
    try {
      result = await future;
      if (capturedContext.mounted) {
        await behaviour.after(capturedContext);
      }
    } catch (e) {
      if (capturedContext.mounted) {
        await behaviour.after(capturedContext);
      }
      rethrow;
    }

    return result;
  }

  static AsyncTaskBehaviour? _default;
}

/// An abstract class that defines the interface for behaviors that can be used with the [AsyncTaskHandler] class.
///
/// The [before] method is executed before the asynchronous operation.
/// The [after] method is executed after the asynchronous operation.
abstract class AsyncTaskBehaviour<T> {
  const AsyncTaskBehaviour();

  /// Method to be executed after the asynchronous operation.
  ///
  /// The [context] parameter provides the [BuildContext] for the operation.
  FutureOr<void> after(BuildContext context);

  /// Method to be executed before the asynchronous operation.
  ///
  /// The [context] parameter provides the [BuildContext] for the operation.
  /// The [arguments] parameter can be used to pass optional arguments to the behavior.
  FutureOr<void> before(BuildContext context, T arguments);
}