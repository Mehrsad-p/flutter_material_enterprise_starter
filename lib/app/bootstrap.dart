import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AppProviderObserver extends ProviderObserver {
//   @override
//   void didUpdateProvider(
//     ProviderBase<Object?> provider,
//     Object? previousValue,
//     Object? newValue,
//     ProviderContainer container,
//   ) {
//     log('Provider Updated: ${provider.name ?? provider.runtimeType}');
//   }

//   @override
//   void providerDidFail(
//     ProviderBase<Object?> provider,
//     Object error,
//     StackTrace stackTrace,
//     ProviderContainer container,
//   ) {
//     log(
//       'Provider Error: ${provider.name ?? provider.runtimeType}',
//       error: error,
//       stackTrace: stackTrace,
//     );
//   }
// }

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  // Run app wrapped in ProviderScope with an Observer
  runApp(ProviderScope(child: await builder()));
}
