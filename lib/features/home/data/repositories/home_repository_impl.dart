import 'package:flutter_material_enterprise_starter/core/errors/result.dart';
import 'package:flutter_material_enterprise_starter/features/home/data/datasources/home_local_datasource.dart';
import 'package:flutter_material_enterprise_starter/features/home/data/mapper/home_mapper.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/entities/home_summary.dart';
import 'package:flutter_material_enterprise_starter/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _localDataSource;

  const HomeRepositoryImpl(this._localDataSource);

  @override
  Future<Result<HomeSummary>> getHomeSummary() {
    return safeApiCall(
      call: () async {
        final dto = await _localDataSource.fetchHomeSummaryMock();
        return dto.toEntity();
      },
    );
  }
}
