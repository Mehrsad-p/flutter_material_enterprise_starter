// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeSummaryDto {

 String get welcomeMessage; int get activeUsersCount; int get pendingTasksCount;
/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryDtoCopyWith<HomeSummaryDto> get copyWith => _$HomeSummaryDtoCopyWithImpl<HomeSummaryDto>(this as HomeSummaryDto, _$identity);

  /// Serializes this HomeSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummaryDto&&(identical(other.welcomeMessage, welcomeMessage) || other.welcomeMessage == welcomeMessage)&&(identical(other.activeUsersCount, activeUsersCount) || other.activeUsersCount == activeUsersCount)&&(identical(other.pendingTasksCount, pendingTasksCount) || other.pendingTasksCount == pendingTasksCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,welcomeMessage,activeUsersCount,pendingTasksCount);

@override
String toString() {
  return 'HomeSummaryDto(welcomeMessage: $welcomeMessage, activeUsersCount: $activeUsersCount, pendingTasksCount: $pendingTasksCount)';
}


}

/// @nodoc
abstract mixin class $HomeSummaryDtoCopyWith<$Res>  {
  factory $HomeSummaryDtoCopyWith(HomeSummaryDto value, $Res Function(HomeSummaryDto) _then) = _$HomeSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String welcomeMessage, int activeUsersCount, int pendingTasksCount
});




}
/// @nodoc
class _$HomeSummaryDtoCopyWithImpl<$Res>
    implements $HomeSummaryDtoCopyWith<$Res> {
  _$HomeSummaryDtoCopyWithImpl(this._self, this._then);

  final HomeSummaryDto _self;
  final $Res Function(HomeSummaryDto) _then;

/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? welcomeMessage = null,Object? activeUsersCount = null,Object? pendingTasksCount = null,}) {
  return _then(_self.copyWith(
welcomeMessage: null == welcomeMessage ? _self.welcomeMessage : welcomeMessage // ignore: cast_nullable_to_non_nullable
as String,activeUsersCount: null == activeUsersCount ? _self.activeUsersCount : activeUsersCount // ignore: cast_nullable_to_non_nullable
as int,pendingTasksCount: null == pendingTasksCount ? _self.pendingTasksCount : pendingTasksCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSummaryDto].
extension HomeSummaryDtoPatterns on HomeSummaryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummaryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String welcomeMessage,  int activeUsersCount,  int pendingTasksCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
return $default(_that.welcomeMessage,_that.activeUsersCount,_that.pendingTasksCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String welcomeMessage,  int activeUsersCount,  int pendingTasksCount)  $default,) {final _that = this;
switch (_that) {
case _HomeSummaryDto():
return $default(_that.welcomeMessage,_that.activeUsersCount,_that.pendingTasksCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String welcomeMessage,  int activeUsersCount,  int pendingTasksCount)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
return $default(_that.welcomeMessage,_that.activeUsersCount,_that.pendingTasksCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeSummaryDto implements HomeSummaryDto {
  const _HomeSummaryDto({required this.welcomeMessage, required this.activeUsersCount, required this.pendingTasksCount});
  factory _HomeSummaryDto.fromJson(Map<String, dynamic> json) => _$HomeSummaryDtoFromJson(json);

@override final  String welcomeMessage;
@override final  int activeUsersCount;
@override final  int pendingTasksCount;

/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryDtoCopyWith<_HomeSummaryDto> get copyWith => __$HomeSummaryDtoCopyWithImpl<_HomeSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummaryDto&&(identical(other.welcomeMessage, welcomeMessage) || other.welcomeMessage == welcomeMessage)&&(identical(other.activeUsersCount, activeUsersCount) || other.activeUsersCount == activeUsersCount)&&(identical(other.pendingTasksCount, pendingTasksCount) || other.pendingTasksCount == pendingTasksCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,welcomeMessage,activeUsersCount,pendingTasksCount);

@override
String toString() {
  return 'HomeSummaryDto(welcomeMessage: $welcomeMessage, activeUsersCount: $activeUsersCount, pendingTasksCount: $pendingTasksCount)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryDtoCopyWith<$Res> implements $HomeSummaryDtoCopyWith<$Res> {
  factory _$HomeSummaryDtoCopyWith(_HomeSummaryDto value, $Res Function(_HomeSummaryDto) _then) = __$HomeSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String welcomeMessage, int activeUsersCount, int pendingTasksCount
});




}
/// @nodoc
class __$HomeSummaryDtoCopyWithImpl<$Res>
    implements _$HomeSummaryDtoCopyWith<$Res> {
  __$HomeSummaryDtoCopyWithImpl(this._self, this._then);

  final _HomeSummaryDto _self;
  final $Res Function(_HomeSummaryDto) _then;

/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? welcomeMessage = null,Object? activeUsersCount = null,Object? pendingTasksCount = null,}) {
  return _then(_HomeSummaryDto(
welcomeMessage: null == welcomeMessage ? _self.welcomeMessage : welcomeMessage // ignore: cast_nullable_to_non_nullable
as String,activeUsersCount: null == activeUsersCount ? _self.activeUsersCount : activeUsersCount // ignore: cast_nullable_to_non_nullable
as int,pendingTasksCount: null == pendingTasksCount ? _self.pendingTasksCount : pendingTasksCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
