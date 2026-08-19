import 'package:freezed_annotation/freezed_annotation.dart';

part 'launcher_state.freezed.dart';

@freezed
class LauncherState with _$LauncherState {
  const factory LauncherState.initial() = _Initial;
  const factory LauncherState.loading() = _Loading;
  const factory LauncherState.success({required bool hasActiveSession}) = _Success;
  const factory LauncherState.error(String message) = _Error;
}
