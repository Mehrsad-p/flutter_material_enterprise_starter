import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/entities/home_summary.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/repositories/home_repository.dart';

class FetchHomeSummaryUseCase {
  final HomeRepository _repository;

  const FetchHomeSummaryUseCase(this._repository);

  Future<Result<HomeSummary>> execute() async {
    return _repository.getHomeSummary();
  }
}
