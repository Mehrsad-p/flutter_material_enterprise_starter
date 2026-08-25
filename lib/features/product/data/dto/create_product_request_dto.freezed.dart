// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_product_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateProductRequestDto {

 String get title; double get price; String? get description;
/// Create a copy of CreateProductRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateProductRequestDtoCopyWith<CreateProductRequestDto> get copyWith => _$CreateProductRequestDtoCopyWithImpl<CreateProductRequestDto>(this as CreateProductRequestDto, _$identity);

  /// Serializes this CreateProductRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateProductRequestDto&&(identical(other.title, title) || other.title == title)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,price,description);

@override
String toString() {
  return 'CreateProductRequestDto(title: $title, price: $price, description: $description)';
}


}

/// @nodoc
abstract mixin class $CreateProductRequestDtoCopyWith<$Res>  {
  factory $CreateProductRequestDtoCopyWith(CreateProductRequestDto value, $Res Function(CreateProductRequestDto) _then) = _$CreateProductRequestDtoCopyWithImpl;
@useResult
$Res call({
 String title, double price, String? description
});




}
/// @nodoc
class _$CreateProductRequestDtoCopyWithImpl<$Res>
    implements $CreateProductRequestDtoCopyWith<$Res> {
  _$CreateProductRequestDtoCopyWithImpl(this._self, this._then);

  final CreateProductRequestDto _self;
  final $Res Function(CreateProductRequestDto) _then;

/// Create a copy of CreateProductRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? price = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateProductRequestDto].
extension CreateProductRequestDtoPatterns on CreateProductRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateProductRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateProductRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateProductRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateProductRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateProductRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateProductRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  double price,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateProductRequestDto() when $default != null:
return $default(_that.title,_that.price,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  double price,  String? description)  $default,) {final _that = this;
switch (_that) {
case _CreateProductRequestDto():
return $default(_that.title,_that.price,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  double price,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _CreateProductRequestDto() when $default != null:
return $default(_that.title,_that.price,_that.description);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CreateProductRequestDto implements CreateProductRequestDto {
  const _CreateProductRequestDto({required this.title, required this.price, this.description});
  factory _CreateProductRequestDto.fromJson(Map<String, dynamic> json) => _$CreateProductRequestDtoFromJson(json);

@override final  String title;
@override final  double price;
@override final  String? description;

/// Create a copy of CreateProductRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateProductRequestDtoCopyWith<_CreateProductRequestDto> get copyWith => __$CreateProductRequestDtoCopyWithImpl<_CreateProductRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateProductRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateProductRequestDto&&(identical(other.title, title) || other.title == title)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,price,description);

@override
String toString() {
  return 'CreateProductRequestDto(title: $title, price: $price, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CreateProductRequestDtoCopyWith<$Res> implements $CreateProductRequestDtoCopyWith<$Res> {
  factory _$CreateProductRequestDtoCopyWith(_CreateProductRequestDto value, $Res Function(_CreateProductRequestDto) _then) = __$CreateProductRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, double price, String? description
});




}
/// @nodoc
class __$CreateProductRequestDtoCopyWithImpl<$Res>
    implements _$CreateProductRequestDtoCopyWith<$Res> {
  __$CreateProductRequestDtoCopyWithImpl(this._self, this._then);

  final _CreateProductRequestDto _self;
  final $Res Function(_CreateProductRequestDto) _then;

/// Create a copy of CreateProductRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? price = null,Object? description = freezed,}) {
  return _then(_CreateProductRequestDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
