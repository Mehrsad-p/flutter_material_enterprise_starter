// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_init_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppInitDto {

 bool get isMaintenanceMode; String get minimumVersion;
/// Create a copy of AppInitDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppInitDtoCopyWith<AppInitDto> get copyWith => _$AppInitDtoCopyWithImpl<AppInitDto>(this as AppInitDto, _$identity);

  /// Serializes this AppInitDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppInitDto&&(identical(other.isMaintenanceMode, isMaintenanceMode) || other.isMaintenanceMode == isMaintenanceMode)&&(identical(other.minimumVersion, minimumVersion) || other.minimumVersion == minimumVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isMaintenanceMode,minimumVersion);

@override
String toString() {
  return 'AppInitDto(isMaintenanceMode: $isMaintenanceMode, minimumVersion: $minimumVersion)';
}


}

/// @nodoc
abstract mixin class $AppInitDtoCopyWith<$Res>  {
  factory $AppInitDtoCopyWith(AppInitDto value, $Res Function(AppInitDto) _then) = _$AppInitDtoCopyWithImpl;
@useResult
$Res call({
 bool isMaintenanceMode, String minimumVersion
});




}
/// @nodoc
class _$AppInitDtoCopyWithImpl<$Res>
    implements $AppInitDtoCopyWith<$Res> {
  _$AppInitDtoCopyWithImpl(this._self, this._then);

  final AppInitDto _self;
  final $Res Function(AppInitDto) _then;

/// Create a copy of AppInitDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isMaintenanceMode = null,Object? minimumVersion = null,}) {
  return _then(_self.copyWith(
isMaintenanceMode: null == isMaintenanceMode ? _self.isMaintenanceMode : isMaintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,minimumVersion: null == minimumVersion ? _self.minimumVersion : minimumVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppInitDto].
extension AppInitDtoPatterns on AppInitDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppInitDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppInitDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppInitDto value)  $default,){
final _that = this;
switch (_that) {
case _AppInitDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppInitDto value)?  $default,){
final _that = this;
switch (_that) {
case _AppInitDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isMaintenanceMode,  String minimumVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppInitDto() when $default != null:
return $default(_that.isMaintenanceMode,_that.minimumVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isMaintenanceMode,  String minimumVersion)  $default,) {final _that = this;
switch (_that) {
case _AppInitDto():
return $default(_that.isMaintenanceMode,_that.minimumVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isMaintenanceMode,  String minimumVersion)?  $default,) {final _that = this;
switch (_that) {
case _AppInitDto() when $default != null:
return $default(_that.isMaintenanceMode,_that.minimumVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppInitDto implements AppInitDto {
  const _AppInitDto({required this.isMaintenanceMode, required this.minimumVersion});
  factory _AppInitDto.fromJson(Map<String, dynamic> json) => _$AppInitDtoFromJson(json);

@override final  bool isMaintenanceMode;
@override final  String minimumVersion;

/// Create a copy of AppInitDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppInitDtoCopyWith<_AppInitDto> get copyWith => __$AppInitDtoCopyWithImpl<_AppInitDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppInitDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppInitDto&&(identical(other.isMaintenanceMode, isMaintenanceMode) || other.isMaintenanceMode == isMaintenanceMode)&&(identical(other.minimumVersion, minimumVersion) || other.minimumVersion == minimumVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isMaintenanceMode,minimumVersion);

@override
String toString() {
  return 'AppInitDto(isMaintenanceMode: $isMaintenanceMode, minimumVersion: $minimumVersion)';
}


}

/// @nodoc
abstract mixin class _$AppInitDtoCopyWith<$Res> implements $AppInitDtoCopyWith<$Res> {
  factory _$AppInitDtoCopyWith(_AppInitDto value, $Res Function(_AppInitDto) _then) = __$AppInitDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isMaintenanceMode, String minimumVersion
});




}
/// @nodoc
class __$AppInitDtoCopyWithImpl<$Res>
    implements _$AppInitDtoCopyWith<$Res> {
  __$AppInitDtoCopyWithImpl(this._self, this._then);

  final _AppInitDto _self;
  final $Res Function(_AppInitDto) _then;

/// Create a copy of AppInitDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isMaintenanceMode = null,Object? minimumVersion = null,}) {
  return _then(_AppInitDto(
isMaintenanceMode: null == isMaintenanceMode ? _self.isMaintenanceMode : isMaintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,minimumVersion: null == minimumVersion ? _self.minimumVersion : minimumVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
