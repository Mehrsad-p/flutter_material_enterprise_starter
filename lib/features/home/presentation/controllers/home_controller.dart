import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/domain.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/usecases/fetch_home_summary_usecase.dart';
import 'package:flutter_material_enterprise_starter/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/states/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
FetchHomeSummaryUseCase fetchHomeSummaryUseCase(
  FetchHomeSummaryUseCaseRef ref,
) {
  final repository = ref.watch(homeRepositoryProvider);
  return FetchHomeSummaryUseCase(repository);
}


@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    Future.microtask(() => loadDashboard());

    return const HomeState.initial();
  }

  Future<void> loadDashboard() async {
    state = const HomeState.loading();

    final useCase = ref.read(fetchHomeSummaryUseCaseProvider);
    final result = await useCase.execute();

    state = result.when(
      success: (summary) => HomeState.success(summary),
      error: (failure) => HomeState.error(failure.message),
    );
  }
}
