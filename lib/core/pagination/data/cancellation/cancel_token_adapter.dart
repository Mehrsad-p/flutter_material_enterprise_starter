import 'package:dio/dio.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/domain/cancellation/domain_cancel_token.dart';

/// Extension to adapt pure domain cancel tokens to Dio-specific [CancelToken] instances.
extension DomainCancelTokenX on DomainCancelToken {
  /// Converts this [DomainCancelToken] into a Dio [CancelToken] and registers
  /// a listener to propagate cancellations.
  CancelToken toDioToken() {
    final dioToken = CancelToken();
    onCancel((reason) {
      if (!dioToken.isCancelled) {
        dioToken.cancel(reason);
      }
    });
    return dioToken;
  }
}
