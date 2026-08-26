import 'package:flutter/material.dart';

/// A declarative, reusable paginated list view with automated scroll detection
/// and load-more footer indicators.
///
/// This component is completely decoupled from Riverpod, controllers, and business logic.
class PaginatedListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback? onLoadMore;
  final Future<void> Function()? onRefresh;
  final bool isFetchingMore;
  final bool hasMore;
  final Widget? emptyWidget;
  final Widget? separatorWidget;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final ScrollController? controller;
  final double scrollThreshold;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onLoadMore,
    this.onRefresh,
    this.isFetchingMore = false,
    this.hasMore = true,
    this.emptyWidget,
    this.separatorWidget,
    this.padding = const EdgeInsets.all(16.0),
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.controller,
    this.scrollThreshold = 0.8,
  });

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final metrics = notification.metrics;
      if (metrics.maxScrollExtent > 0) {
        final scrollPercentage = metrics.pixels / metrics.maxScrollExtent;
        if (scrollPercentage >= scrollThreshold && hasMore && !isFetchingMore) {
          onLoadMore?.call();
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && !isFetchingMore) {
      final emptyView = emptyWidget ??
          const Center(
            child: Text('No items found'),
          );

      if (onRefresh != null) {
        return RefreshIndicator(
          onRefresh: onRefresh!,
          child: SingleChildScrollView(
            physics: physics,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: emptyView,
            ),
          ),
        );
      }
      return emptyView;
    }

    final itemCount = items.length + (hasMore || isFetchingMore ? 1 : 0);

    Widget listView = NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: ListView.separated(
        controller: controller,
        physics: physics,
        padding: padding,
        itemCount: itemCount,
        separatorBuilder: (context, index) {
          if (index < items.length - 1) {
            return separatorWidget ?? const SizedBox(height: 8);
          }
          return const SizedBox.shrink();
        },
        itemBuilder: (context, index) {
          if (index < items.length) {
            return itemBuilder(context, items[index], index);
          } else {
            return LoadMoreFooter(
              isFetchingMore: isFetchingMore,
              hasMore: hasMore,
            );
          }
        },
      ),
    );

    if (onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }
}

/// Footer indicator displayed at the bottom of a paginated list.
class LoadMoreFooter extends StatelessWidget {
  final bool isFetchingMore;
  final bool hasMore;

  const LoadMoreFooter({
    super.key,
    required this.isFetchingMore,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    if (isFetchingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
