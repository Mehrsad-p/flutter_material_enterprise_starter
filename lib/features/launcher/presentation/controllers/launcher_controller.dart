import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/domain.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/domain/usecases/initialize_app_usecase.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/data/repositories/launcher_repository_impl.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/presentation/states/launcher_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launcher_controller.g.dart';

@riverpod
InitializeAppUseCase initializeAppUseCase(InitializeAppUseCaseRef ref) {
  final repository = ref.watch(launcherRepositoryProvider);
  return InitializeAppUseCase(repository);
}


@riverpod
class LauncherController extends _$LauncherController {
  @override
  LauncherState build() {
    Future.microtask(() => initApp());
    return const LauncherState.initial();
  }

  Future<void> initApp() async {
    state = const LauncherState.loading();

    final useCase = ref.read(initializeAppUseCaseProvider);
    final result = await useCase.execute();

    state = await result.when(
      success: (config) async {
        if (config.isMaintenanceMode) {
          return const LauncherState.error('برنامه در دست تعمیر است');
        }
        final sessionResult = await ref.read(launcherRepositoryProvider).checkUserSession();
        return sessionResult.when(
          success: (hasSession) => LauncherState.success(hasActiveSession: hasSession),
          error: (failure) => LauncherState.error(failure.message),
        );
      },
      error: (failure) => LauncherState.error(failure.message),
    );
  }
}
