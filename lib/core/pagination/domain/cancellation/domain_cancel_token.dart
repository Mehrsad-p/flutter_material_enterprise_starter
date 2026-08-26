/// A pure Dart cancel token that allows the domain and presentation layers
/// to signal cancellation without depending on third-party networking clients (like Dio).
class DomainCancelToken {
  bool _isCancelled = false;
  bool get isCancelled => _isCancelled;

  final List<void Function(String?)> _listeners = [];

  /// Registers a callback to be invoked when this token is cancelled.
  void onCancel(void Function(String? reason) callback) {
    if (_isCancelled) {
      callback(null);
    } else {
      _listeners.add(callback);
    }
  }

  /// Cancels the associated network operation, notifying all registered listeners.
  void cancel([String? reason]) {
    if (_isCancelled) return;
    _isCancelled = true;
    for (final listener in _listeners) {
      listener(reason);
    }
    _listeners.clear();
  }
}
