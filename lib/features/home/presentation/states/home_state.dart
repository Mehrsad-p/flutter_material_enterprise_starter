import 'package:flutter_material_enterprise_starter/features/home/domain/entities/home_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.success(HomeSummary summary) = _Success;
  const factory HomeState.error(String message) = _Error;
}
