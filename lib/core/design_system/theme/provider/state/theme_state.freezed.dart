// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppThemeFonts {

 String get bodyFont; String get displayFont;
/// Create a copy of AppThemeFonts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppThemeFontsCopyWith<AppThemeFonts> get copyWith => _$AppThemeFontsCopyWithImpl<AppThemeFonts>(this as AppThemeFonts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppThemeFonts&&(identical(other.bodyFont, bodyFont) || other.bodyFont == bodyFont)&&(identical(other.displayFont, displayFont) || other.displayFont == displayFont));
}


@override
int get hashCode => Object.hash(runtimeType,bodyFont,displayFont);

@override
String toString() {
  return 'AppThemeFonts(bodyFont: $bodyFont, displayFont: $displayFont)';
}


}

/// @nodoc
abstract mixin class $AppThemeFontsCopyWith<$Res>  {
  factory $AppThemeFontsCopyWith(AppThemeFonts value, $Res Function(AppThemeFonts) _then) = _$AppThemeFontsCopyWithImpl;
@useResult
$Res call({
 String bodyFont, String displayFont
});




}
/// @nodoc
class _$AppThemeFontsCopyWithImpl<$Res>
    implements $AppThemeFontsCopyWith<$Res> {
  _$AppThemeFontsCopyWithImpl(this._self, this._then);

  final AppThemeFonts _self;
  final $Res Function(AppThemeFonts) _then;

/// Create a copy of AppThemeFonts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bodyFont = null,Object? displayFont = null,}) {
  return _then(_self.copyWith(
bodyFont: null == bodyFont ? _self.bodyFont : bodyFont // ignore: cast_nullable_to_non_nullable
as String,displayFont: null == displayFont ? _self.displayFont : displayFont // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppThemeFonts].
extension AppThemeFontsPatterns on AppThemeFonts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppThemeFonts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppThemeFonts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppThemeFonts value)  $default,){
final _that = this;
switch (_that) {
case _AppThemeFonts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppThemeFonts value)?  $default,){
final _that = this;
switch (_that) {
case _AppThemeFonts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bodyFont,  String displayFont)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppThemeFonts() when $default != null:
return $default(_that.bodyFont,_that.displayFont);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bodyFont,  String displayFont)  $default,) {final _that = this;
switch (_that) {
case _AppThemeFonts():
return $default(_that.bodyFont,_that.displayFont);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bodyFont,  String displayFont)?  $default,) {final _that = this;
switch (_that) {
case _AppThemeFonts() when $default != null:
return $default(_that.bodyFont,_that.displayFont);case _:
  return null;

}
}

}

/// @nodoc


class _AppThemeFonts implements AppThemeFonts {
  const _AppThemeFonts({this.bodyFont = 'IRANSans', this.displayFont = 'IRANSans'});
  

@override@JsonKey() final  String bodyFont;
@override@JsonKey() final  String displayFont;

/// Create a copy of AppThemeFonts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppThemeFontsCopyWith<_AppThemeFonts> get copyWith => __$AppThemeFontsCopyWithImpl<_AppThemeFonts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppThemeFonts&&(identical(other.bodyFont, bodyFont) || other.bodyFont == bodyFont)&&(identical(other.displayFont, displayFont) || other.displayFont == displayFont));
}


@override
int get hashCode => Object.hash(runtimeType,bodyFont,displayFont);

@override
String toString() {
  return 'AppThemeFonts(bodyFont: $bodyFont, displayFont: $displayFont)';
}


}

/// @nodoc
abstract mixin class _$AppThemeFontsCopyWith<$Res> implements $AppThemeFontsCopyWith<$Res> {
  factory _$AppThemeFontsCopyWith(_AppThemeFonts value, $Res Function(_AppThemeFonts) _then) = __$AppThemeFontsCopyWithImpl;
@override @useResult
$Res call({
 String bodyFont, String displayFont
});




}
/// @nodoc
class __$AppThemeFontsCopyWithImpl<$Res>
    implements _$AppThemeFontsCopyWith<$Res> {
  __$AppThemeFontsCopyWithImpl(this._self, this._then);

  final _AppThemeFonts _self;
  final $Res Function(_AppThemeFonts) _then;

/// Create a copy of AppThemeFonts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bodyFont = null,Object? displayFont = null,}) {
  return _then(_AppThemeFonts(
bodyFont: null == bodyFont ? _self.bodyFont : bodyFont // ignore: cast_nullable_to_non_nullable
as String,displayFont: null == displayFont ? _self.displayFont : displayFont // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ThemeState {

 ThemeMode get themeMode; Color? get seedColor; AppThemeFonts get fonts; FontSize get fontSize;
/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeStateCopyWith<ThemeState> get copyWith => _$ThemeStateCopyWithImpl<ThemeState>(this as ThemeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.seedColor, seedColor) || other.seedColor == seedColor)&&(identical(other.fonts, fonts) || other.fonts == fonts)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,seedColor,fonts,fontSize);

@override
String toString() {
  return 'ThemeState(themeMode: $themeMode, seedColor: $seedColor, fonts: $fonts, fontSize: $fontSize)';
}


}

/// @nodoc
abstract mixin class $ThemeStateCopyWith<$Res>  {
  factory $ThemeStateCopyWith(ThemeState value, $Res Function(ThemeState) _then) = _$ThemeStateCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, Color? seedColor, AppThemeFonts fonts, FontSize fontSize
});


$AppThemeFontsCopyWith<$Res> get fonts;

}
/// @nodoc
class _$ThemeStateCopyWithImpl<$Res>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._self, this._then);

  final ThemeState _self;
  final $Res Function(ThemeState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? seedColor = freezed,Object? fonts = null,Object? fontSize = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,seedColor: freezed == seedColor ? _self.seedColor : seedColor // ignore: cast_nullable_to_non_nullable
as Color?,fonts: null == fonts ? _self.fonts : fonts // ignore: cast_nullable_to_non_nullable
as AppThemeFonts,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as FontSize,
  ));
}
/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppThemeFontsCopyWith<$Res> get fonts {
  
  return $AppThemeFontsCopyWith<$Res>(_self.fonts, (value) {
    return _then(_self.copyWith(fonts: value));
  });
}
}


/// Adds pattern-matching-related methods to [ThemeState].
extension ThemeStatePatterns on ThemeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeState value)  $default,){
final _that = this;
switch (_that) {
case _ThemeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeState value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  Color? seedColor,  AppThemeFonts fonts,  FontSize fontSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
return $default(_that.themeMode,_that.seedColor,_that.fonts,_that.fontSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  Color? seedColor,  AppThemeFonts fonts,  FontSize fontSize)  $default,) {final _that = this;
switch (_that) {
case _ThemeState():
return $default(_that.themeMode,_that.seedColor,_that.fonts,_that.fontSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  Color? seedColor,  AppThemeFonts fonts,  FontSize fontSize)?  $default,) {final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
return $default(_that.themeMode,_that.seedColor,_that.fonts,_that.fontSize);case _:
  return null;

}
}

}

/// @nodoc


class _ThemeState implements ThemeState {
   _ThemeState({this.themeMode = ThemeMode.system, this.seedColor, this.fonts = const AppThemeFonts(), this.fontSize = FontSize.medium});
  

@override@JsonKey() final  ThemeMode themeMode;
@override final  Color? seedColor;
@override@JsonKey() final  AppThemeFonts fonts;
@override@JsonKey() final  FontSize fontSize;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeStateCopyWith<_ThemeState> get copyWith => __$ThemeStateCopyWithImpl<_ThemeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.seedColor, seedColor) || other.seedColor == seedColor)&&(identical(other.fonts, fonts) || other.fonts == fonts)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,seedColor,fonts,fontSize);

@override
String toString() {
  return 'ThemeState(themeMode: $themeMode, seedColor: $seedColor, fonts: $fonts, fontSize: $fontSize)';
}


}

/// @nodoc
abstract mixin class _$ThemeStateCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory _$ThemeStateCopyWith(_ThemeState value, $Res Function(_ThemeState) _then) = __$ThemeStateCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, Color? seedColor, AppThemeFonts fonts, FontSize fontSize
});


@override $AppThemeFontsCopyWith<$Res> get fonts;

}
/// @nodoc
class __$ThemeStateCopyWithImpl<$Res>
    implements _$ThemeStateCopyWith<$Res> {
  __$ThemeStateCopyWithImpl(this._self, this._then);

  final _ThemeState _self;
  final $Res Function(_ThemeState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? seedColor = freezed,Object? fonts = null,Object? fontSize = null,}) {
  return _then(_ThemeState(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,seedColor: freezed == seedColor ? _self.seedColor : seedColor // ignore: cast_nullable_to_non_nullable
as Color?,fonts: null == fonts ? _self.fonts : fonts // ignore: cast_nullable_to_non_nullable
as AppThemeFonts,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as FontSize,
  ));
}

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppThemeFontsCopyWith<$Res> get fonts {
  
  return $AppThemeFontsCopyWith<$Res>(_self.fonts, (value) {
    return _then(_self.copyWith(fonts: value));
  });
}
}

// dart format on
