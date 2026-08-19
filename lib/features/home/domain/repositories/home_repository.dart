import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/entities/home_summary.dart';

abstract interface class HomeRepository {
  Future<Result<HomeSummary>> getHomeSummary();
}
