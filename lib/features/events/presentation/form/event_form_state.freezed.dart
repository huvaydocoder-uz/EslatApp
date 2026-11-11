// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventFormState {

 ImportantEvent get draft; bool get isEditing; bool get yearUnknown; bool get smsEnabled; String get phoneInput; bool get emojiChosenByUser; bool get submitted; bool get isSaving; bool get saveFailed; int get maxReminders;
/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventFormStateCopyWith<EventFormState> get copyWith => _$EventFormStateCopyWithImpl<EventFormState>(this as EventFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EventFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventFormState&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.isEditing, _this.isEditing) || other.isEditing == _this.isEditing)&&(identical(other.yearUnknown, _this.yearUnknown) || other.yearUnknown == _this.yearUnknown)&&(identical(other.smsEnabled, _this.smsEnabled) || other.smsEnabled == _this.smsEnabled)&&(identical(other.phoneInput, _this.phoneInput) || other.phoneInput == _this.phoneInput)&&(identical(other.emojiChosenByUser, _this.emojiChosenByUser) || other.emojiChosenByUser == _this.emojiChosenByUser)&&(identical(other.submitted, _this.submitted) || other.submitted == _this.submitted)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.saveFailed, _this.saveFailed) || other.saveFailed == _this.saveFailed)&&(identical(other.maxReminders, _this.maxReminders) || other.maxReminders == _this.maxReminders));
}


@override
int get hashCode {
  final _this = this as EventFormState;
  return Object.hash(runtimeType,_this.draft,_this.isEditing,_this.yearUnknown,_this.smsEnabled,_this.phoneInput,_this.emojiChosenByUser,_this.submitted,_this.isSaving,_this.saveFailed,_this.maxReminders);
}

@override
String toString() {
  final _this = this as EventFormState;
  return 'EventFormState(draft: ${_this.draft}, isEditing: ${_this.isEditing}, yearUnknown: ${_this.yearUnknown}, smsEnabled: ${_this.smsEnabled}, phoneInput: ${_this.phoneInput}, emojiChosenByUser: ${_this.emojiChosenByUser}, submitted: ${_this.submitted}, isSaving: ${_this.isSaving}, saveFailed: ${_this.saveFailed}, maxReminders: ${_this.maxReminders})';
}


}

/// @nodoc
abstract mixin class $EventFormStateCopyWith<$Res>  {
  factory $EventFormStateCopyWith(EventFormState value, $Res Function(EventFormState) _then) = _$EventFormStateCopyWithImpl;
@useResult
$Res call({
 ImportantEvent draft, bool isEditing, bool yearUnknown, bool smsEnabled, String phoneInput, bool emojiChosenByUser, bool submitted, bool isSaving, bool saveFailed, int maxReminders
});


$ImportantEventCopyWith<$Res> get draft;

}
/// @nodoc
class _$EventFormStateCopyWithImpl<$Res>
    implements $EventFormStateCopyWith<$Res> {
  _$EventFormStateCopyWithImpl(this._self, this._then);

  final EventFormState _self;
  final $Res Function(EventFormState) _then;

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? isEditing = null,Object? yearUnknown = null,Object? smsEnabled = null,Object? phoneInput = null,Object? emojiChosenByUser = null,Object? submitted = null,Object? isSaving = null,Object? saveFailed = null,Object? maxReminders = null,}) {
  return _then(EventFormState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ImportantEvent,isEditing: null == isEditing ? _self.isEditing : isEditing // ignore: cast_nullable_to_non_nullable
as bool,yearUnknown: null == yearUnknown ? _self.yearUnknown : yearUnknown // ignore: cast_nullable_to_non_nullable
as bool,smsEnabled: null == smsEnabled ? _self.smsEnabled : smsEnabled // ignore: cast_nullable_to_non_nullable
as bool,phoneInput: null == phoneInput ? _self.phoneInput : phoneInput // ignore: cast_nullable_to_non_nullable
as String,emojiChosenByUser: null == emojiChosenByUser ? _self.emojiChosenByUser : emojiChosenByUser // ignore: cast_nullable_to_non_nullable
as bool,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saveFailed: null == saveFailed ? _self.saveFailed : saveFailed // ignore: cast_nullable_to_non_nullable
as bool,maxReminders: null == maxReminders ? _self.maxReminders : maxReminders // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportantEventCopyWith<$Res> get draft {
  
  return $ImportantEventCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventFormState].
extension EventFormStatePatterns on EventFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventFormState value)  $default,){
final _that = this;
switch (_that) {
case _EventFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventFormState value)?  $default,){
final _that = this;
switch (_that) {
case _EventFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ImportantEvent draft,  bool isEditing,  bool yearUnknown,  bool smsEnabled,  String phoneInput,  bool emojiChosenByUser,  bool submitted,  bool isSaving,  bool saveFailed,  int maxReminders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventFormState() when $default != null:
return $default(_that.draft,_that.isEditing,_that.yearUnknown,_that.smsEnabled,_that.phoneInput,_that.emojiChosenByUser,_that.submitted,_that.isSaving,_that.saveFailed,_that.maxReminders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ImportantEvent draft,  bool isEditing,  bool yearUnknown,  bool smsEnabled,  String phoneInput,  bool emojiChosenByUser,  bool submitted,  bool isSaving,  bool saveFailed,  int maxReminders)  $default,) {final _that = this;
switch (_that) {
case _EventFormState():
return $default(_that.draft,_that.isEditing,_that.yearUnknown,_that.smsEnabled,_that.phoneInput,_that.emojiChosenByUser,_that.submitted,_that.isSaving,_that.saveFailed,_that.maxReminders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ImportantEvent draft,  bool isEditing,  bool yearUnknown,  bool smsEnabled,  String phoneInput,  bool emojiChosenByUser,  bool submitted,  bool isSaving,  bool saveFailed,  int maxReminders)?  $default,) {final _that = this;
switch (_that) {
case _EventFormState() when $default != null:
return $default(_that.draft,_that.isEditing,_that.yearUnknown,_that.smsEnabled,_that.phoneInput,_that.emojiChosenByUser,_that.submitted,_that.isSaving,_that.saveFailed,_that.maxReminders);case _:
  return null;

}
}

}

/// @nodoc


class _EventFormState extends EventFormState {
  const _EventFormState({required this.draft, this.isEditing = false, this.yearUnknown = false, this.smsEnabled = false, this.phoneInput = '', this.emojiChosenByUser = false, this.submitted = false, this.isSaving = false, this.saveFailed = false, this.maxReminders = 2}): super._();
  

@override final  ImportantEvent draft;
@override@JsonKey() final  bool isEditing;
@override@JsonKey() final  bool yearUnknown;
@override@JsonKey() final  bool smsEnabled;
@override@JsonKey() final  String phoneInput;
@override@JsonKey() final  bool emojiChosenByUser;
@override@JsonKey() final  bool submitted;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool saveFailed;
@override@JsonKey() final  int maxReminders;

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventFormStateCopyWith<_EventFormState> get copyWith => __$EventFormStateCopyWithImpl<_EventFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventFormState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.isEditing, isEditing) || other.isEditing == isEditing)&&(identical(other.yearUnknown, yearUnknown) || other.yearUnknown == yearUnknown)&&(identical(other.smsEnabled, smsEnabled) || other.smsEnabled == smsEnabled)&&(identical(other.phoneInput, phoneInput) || other.phoneInput == phoneInput)&&(identical(other.emojiChosenByUser, emojiChosenByUser) || other.emojiChosenByUser == emojiChosenByUser)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.saveFailed, saveFailed) || other.saveFailed == saveFailed)&&(identical(other.maxReminders, maxReminders) || other.maxReminders == maxReminders));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft,isEditing,yearUnknown,smsEnabled,phoneInput,emojiChosenByUser,submitted,isSaving,saveFailed,maxReminders);
}

@override
String toString() {
    return 'EventFormState(draft: $draft, isEditing: $isEditing, yearUnknown: $yearUnknown, smsEnabled: $smsEnabled, phoneInput: $phoneInput, emojiChosenByUser: $emojiChosenByUser, submitted: $submitted, isSaving: $isSaving, saveFailed: $saveFailed, maxReminders: $maxReminders)';
}


}

/// @nodoc
abstract mixin class _$EventFormStateCopyWith<$Res> implements $EventFormStateCopyWith<$Res> {
  factory _$EventFormStateCopyWith(_EventFormState value, $Res Function(_EventFormState) _then) = __$EventFormStateCopyWithImpl;
@override @useResult
$Res call({
 ImportantEvent draft, bool isEditing, bool yearUnknown, bool smsEnabled, String phoneInput, bool emojiChosenByUser, bool submitted, bool isSaving, bool saveFailed, int maxReminders
});


@override $ImportantEventCopyWith<$Res> get draft;

}
/// @nodoc
class __$EventFormStateCopyWithImpl<$Res>
    implements _$EventFormStateCopyWith<$Res> {
  __$EventFormStateCopyWithImpl(this._self, this._then);

  final _EventFormState _self;
  final $Res Function(_EventFormState) _then;

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? isEditing = null,Object? yearUnknown = null,Object? smsEnabled = null,Object? phoneInput = null,Object? emojiChosenByUser = null,Object? submitted = null,Object? isSaving = null,Object? saveFailed = null,Object? maxReminders = null,}) {
  return _then(_EventFormState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ImportantEvent,isEditing: null == isEditing ? _self.isEditing : isEditing // ignore: cast_nullable_to_non_nullable
as bool,yearUnknown: null == yearUnknown ? _self.yearUnknown : yearUnknown // ignore: cast_nullable_to_non_nullable
as bool,smsEnabled: null == smsEnabled ? _self.smsEnabled : smsEnabled // ignore: cast_nullable_to_non_nullable
as bool,phoneInput: null == phoneInput ? _self.phoneInput : phoneInput // ignore: cast_nullable_to_non_nullable
as String,emojiChosenByUser: null == emojiChosenByUser ? _self.emojiChosenByUser : emojiChosenByUser // ignore: cast_nullable_to_non_nullable
as bool,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saveFailed: null == saveFailed ? _self.saveFailed : saveFailed // ignore: cast_nullable_to_non_nullable
as bool,maxReminders: null == maxReminders ? _self.maxReminders : maxReminders // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportantEventCopyWith<$Res> get draft {
  
  return $ImportantEventCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
