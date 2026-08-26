import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/core/feedback/presentation/controllers/app_feedback_controller.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/domain/cancellation/domain_cancel_token.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/domain/entities/paginated_data.dart';
import 'package:flutter_material_enterprise_starter/core/pagination/presentation/state/paginated_state.dart';

/// A reusable mixin on [AutoDisposeAsyncNotifier] providing standardized paginated fetching,
/// request versioning (race-condition prevention), non-destructive error recovery, and
/// domain-agnostic network cancellation support.
mixin PaginationNotifierMixin<T> on AutoDisposeAsyncNotifier<PaginatedState<T>> {
  int _requestVersion = 0;
  DomainCancelToken? _cancelToken;

  /// Abstract method to be implemented by feature controllers to fetch a specific page.
  ///
  /// Consuming repositories must adapt [cancelToken] to their networking client.
  Future<Result<PaginatedData<T>>> fetchPage(int page, {DomainCancelToken? cancelToken});

  /// Helper method for initial build/load.
  ///
  /// Increments request version and fetches page 1.
  Future<PaginatedState<T>> initialLoad() async {
    // Ensure cancellation token is cleaned up when the notifier is disposed
    ref.onDispose(() => _cancelToken?.cancel('Notifier disposed'));

    _cancelToken?.cancel('Cancelled by new request');
    _cancelToken = DomainCancelToken();

    final currentVersion = ++_requestVersion;
    final result = await fetchPage(1, cancelToken: _cancelToken);

    if (currentVersion != _requestVersion) {
      return const PaginatedState();
    }

    return result.when(
      success: (data) => PaginatedState<T>(
        items: data.items,
        currentPage: 1,
        isFetchingMore: false,
        hasMore: data.hasMore,
      ),
      error: (failure) => throw failure,
    );
  }

  /// Refreshes the paginated list from page 1, cancelling any active requests.
  Future<void> refreshPaginated() async {
    _cancelToken?.cancel('Cancelled by new request');
    _cancelToken = DomainCancelToken();

    final currentVersion = ++_requestVersion;
    final result = await fetchPage(1, cancelToken: _cancelToken);

    if (currentVersion != _requestVersion) {
      return;
    }

    result.when(
      success: (data) {
        state = AsyncValue.data(PaginatedState<T>(
          items: data.items,
          currentPage: 1,
          isFetchingMore: false,
          hasMore: data.hasMore,
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }

  /// Fetches and appends the next page of items.
  Future<void> loadMore() async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.isFetchingMore || !currentState.hasMore) {
      return;
    }

    _cancelToken?.cancel('Cancelled by new request');
    _cancelToken = DomainCancelToken();

    final currentVersion = ++_requestVersion;

    // Set loading indicator for bottom footer
    state = AsyncValue.data(currentState.copyWith(isFetchingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await fetchPage(nextPage, cancelToken: _cancelToken);

    // Race condition check: silently discard if request version changed
    if (currentVersion != _requestVersion) {
      return;
    }

    result.when(
      success: (paginatedData) {
        state = AsyncValue.data(currentState.copyWith(
          items: [...currentState.items, ...paginatedData.items],
          currentPage: nextPage,
          hasMore: paginatedData.hasMore,
          isFetchingMore: false,
        ));
      },
      error: (failure) {
        // Non-destructive error recovery: revert loading indicator while preserving items
        state = AsyncValue.data(currentState.copyWith(isFetchingMore: false));
        // Dispatch failure notification via global feedback controller
        ref.read(appFeedbackControllerProvider.notifier).showFailure(failure);
      },
    );
  }
}

