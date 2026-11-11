// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'important_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImportantEvent {

@JsonKey(includeToJson: false, includeFromJson: false) String get id; String get title; String? get personName;@JsonKey(unknownEnumValue: EventCategory.other) EventCategory get category;/// Foydalanuvchi yaratgan tur (`users/{uid}/categories/{id}`); bo'lsa,
/// `category` = `other`.
 String? get customCategoryId; String get emoji; int get day; int get month; int? get year; String? get time; bool get repeatYearly; List<int> get remindDaysBefore;/// Eslatma (va avtomatik SMS) shu vaqtda: "HH:mm".
 String get notifyTime; bool get alarmEnabled;@JsonKey(unknownEnumValue: SmsMode.off) SmsMode get smsMode; String? get phone; String? get smsText; String? get note;
/// Create a copy of ImportantEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportantEventCopyWith<ImportantEvent> get copyWith => _$ImportantEventCopyWithImpl<ImportantEvent>(this as ImportantEvent, _$identity);

  /// Serializes this ImportantEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ImportantEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportantEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.personName, _this.personName) || other.personName == _this.personName)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.customCategoryId, _this.customCategoryId) || other.customCategoryId == _this.customCategoryId)&&(identical(other.emoji, _this.emoji) || other.emoji == _this.emoji)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.repeatYearly, _this.repeatYearly) || other.repeatYearly == _this.repeatYearly)&&const DeepCollectionEquality().equals(other.remindDaysBefore, _this.remindDaysBefore)&&(identical(other.notifyTime, _this.notifyTime) || other.notifyTime == _this.notifyTime)&&(identical(other.alarmEnabled, _this.alarmEnabled) || other.alarmEnabled == _this.alarmEnabled)&&(identical(other.smsMode, _this.smsMode) || other.smsMode == _this.smsMode)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.smsText, _this.smsText) || other.smsText == _this.smsText)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ImportantEvent;
  return Object.hash(runtimeType,_this.id,_this.title,_this.personName,_this.category,_this.customCategoryId,_this.emoji,_this.day,_this.month,_this.year,_this.time,_this.repeatYearly,const DeepCollectionEquality().hash(_this.remindDaysBefore),_this.notifyTime,_this.alarmEnabled,_this.smsMode,_this.phone,_this.smsText,_this.note);
}

@override
String toString() {
  final _this = this as ImportantEvent;
  return 'ImportantEvent(id: ${_this.id}, title: ${_this.title}, personName: ${_this.personName}, category: ${_this.category}, customCategoryId: ${_this.customCategoryId}, emoji: ${_this.emoji}, day: ${_this.day}, month: ${_this.month}, year: ${_this.year}, time: ${_this.time}, repeatYearly: ${_this.repeatYearly}, remindDaysBefore: ${_this.remindDaysBefore}, notifyTime: ${_this.notifyTime}, alarmEnabled: ${_this.alarmEnabled}, smsMode: ${_this.smsMode}, phone: ${_this.phone}, smsText: ${_this.smsText}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $ImportantEventCopyWith<$Res>  {
  factory $ImportantEventCopyWith(ImportantEvent value, $Res Function(ImportantEvent) _then) = _$ImportantEventCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false, includeFromJson: false) String id, String title, String? personName,@JsonKey(unknownEnumValue: EventCategory.other) EventCategory category, String? customCategoryId, String emoji, int day, int month, int? year, String? time, bool repeatYearly, List<int> remindDaysBefore, String notifyTime, bool alarmEnabled,@JsonKey(unknownEnumValue: SmsMode.off) SmsMode smsMode, String? phone, String? smsText, String? note
});




}
/// @nodoc
class _$ImportantEventCopyWithImpl<$Res>
    implements $ImportantEventCopyWith<$Res> {
  _$ImportantEventCopyWithImpl(this._self, this._then);

  final ImportantEvent _self;
  final $Res Function(ImportantEvent) _then;

/// Create a copy of ImportantEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? personName = freezed,Object? category = null,Object? customCategoryId = freezed,Object? emoji = null,Object? day = null,Object? month = null,Object? year = freezed,Object? time = freezed,Object? repeatYearly = null,Object? remindDaysBefore = null,Object? notifyTime = null,Object? alarmEnabled = null,Object? smsMode = null,Object? phone = freezed,Object? smsText = freezed,Object? note = freezed,}) {
  return _then(ImportantEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,personName: freezed == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,customCategoryId: freezed == customCategoryId ? _self.customCategoryId : customCategoryId // ignore: cast_nullable_to_non_nullable
as String?,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,repeatYearly: null == repeatYearly ? _self.repeatYearly : repeatYearly // ignore: cast_nullable_to_non_nullable
as bool,remindDaysBefore: null == remindDaysBefore ? _self.remindDaysBefore : remindDaysBefore // ignore: cast_nullable_to_non_nullable
as List<int>,notifyTime: null == notifyTime ? _self.notifyTime : notifyTime // ignore: cast_nullable_to_non_nullable
as String,alarmEnabled: null == alarmEnabled ? _self.alarmEnabled : alarmEnabled // ignore: cast_nullable_to_non_nullable
as bool,smsMode: null == smsMode ? _self.smsMode : smsMode // ignore: cast_nullable_to_non_nullable
as SmsMode,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,smsText: freezed == smsText ? _self.smsText : smsText // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportantEvent].
extension ImportantEventPatterns on ImportantEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportantEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportantEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportantEvent value)  $default,){
final _that = this;
switch (_that) {
case _ImportantEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportantEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ImportantEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false, includeFromJson: false)  String id,  String title,  String? personName, @JsonKey(unknownEnumValue: EventCategory.other)  EventCategory category,  String? customCategoryId,  String emoji,  int day,  int month,  int? year,  String? time,  bool repeatYearly,  List<int> remindDaysBefore,  String notifyTime,  bool alarmEnabled, @JsonKey(unknownEnumValue: SmsMode.off)  SmsMode smsMode,  String? phone,  String? smsText,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportantEvent() when $default != null:
return $default(_that.id,_that.title,_that.personName,_that.category,_that.customCategoryId,_that.emoji,_that.day,_that.month,_that.year,_that.time,_that.repeatYearly,_that.remindDaysBefore,_that.notifyTime,_that.alarmEnabled,_that.smsMode,_that.phone,_that.smsText,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false, includeFromJson: false)  String id,  String title,  String? personName, @JsonKey(unknownEnumValue: EventCategory.other)  EventCategory category,  String? customCategoryId,  String emoji,  int day,  int month,  int? year,  String? time,  bool repeatYearly,  List<int> remindDaysBefore,  String notifyTime,  bool alarmEnabled, @JsonKey(unknownEnumValue: SmsMode.off)  SmsMode smsMode,  String? phone,  String? smsText,  String? note)  $default,) {final _that = this;
switch (_that) {
case _ImportantEvent():
return $default(_that.id,_that.title,_that.personName,_that.category,_that.customCategoryId,_that.emoji,_that.day,_that.month,_that.year,_that.time,_that.repeatYearly,_that.remindDaysBefore,_that.notifyTime,_that.alarmEnabled,_that.smsMode,_that.phone,_that.smsText,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false, includeFromJson: false)  String id,  String title,  String? personName, @JsonKey(unknownEnumValue: EventCategory.other)  EventCategory category,  String? customCategoryId,  String emoji,  int day,  int month,  int? year,  String? time,  bool repeatYearly,  List<int> remindDaysBefore,  String notifyTime,  bool alarmEnabled, @JsonKey(unknownEnumValue: SmsMode.off)  SmsMode smsMode,  String? phone,  String? smsText,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _ImportantEvent() when $default != null:
return $default(_that.id,_that.title,_that.personName,_that.category,_that.customCategoryId,_that.emoji,_that.day,_that.month,_that.year,_that.time,_that.repeatYearly,_that.remindDaysBefore,_that.notifyTime,_that.alarmEnabled,_that.smsMode,_that.phone,_that.smsText,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImportantEvent extends ImportantEvent {
  const _ImportantEvent({@JsonKey(includeToJson: false, includeFromJson: false) this.id = '', required this.title, this.personName, @JsonKey(unknownEnumValue: EventCategory.other) required this.category, this.customCategoryId, required this.emoji, required this.day, required this.month, this.year, this.time, this.repeatYearly = true,  List<int> remindDaysBefore = const <int>[0, 1], this.notifyTime = defaultNotifyTime, this.alarmEnabled = true, @JsonKey(unknownEnumValue: SmsMode.off) this.smsMode = SmsMode.off, this.phone, this.smsText, this.note}): _remindDaysBefore = remindDaysBefore,super._();
  factory _ImportantEvent.fromJson(Map<String, dynamic> json) => _$ImportantEventFromJson(json);

@override@JsonKey(includeToJson: false, includeFromJson: false) final  String id;
@override final  String title;
@override final  String? personName;
@override@JsonKey(unknownEnumValue: EventCategory.other) final  EventCategory category;
/// Foydalanuvchi yaratgan tur (`users/{uid}/categories/{id}`); bo'lsa,
/// `category` = `other`.
@override final  String? customCategoryId;
@override final  String emoji;
@override final  int day;
@override final  int month;
@override final  int? year;
@override final  String? time;
@override@JsonKey() final  bool repeatYearly;
 final  List<int> _remindDaysBefore;
@override@JsonKey() List<int> get remindDaysBefore {
  if (_remindDaysBefore is EqualUnmodifiableListView) return _remindDaysBefore;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remindDaysBefore);
}

/// Eslatma (va avtomatik SMS) shu vaqtda: "HH:mm".
@override@JsonKey() final  String notifyTime;
@override@JsonKey() final  bool alarmEnabled;
@override@JsonKey(unknownEnumValue: SmsMode.off) final  SmsMode smsMode;
@override final  String? phone;
@override final  String? smsText;
@override final  String? note;

/// Create a copy of ImportantEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportantEventCopyWith<_ImportantEvent> get copyWith => __$ImportantEventCopyWithImpl<_ImportantEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImportantEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportantEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.category, category) || other.category == category)&&(identical(other.customCategoryId, customCategoryId) || other.customCategoryId == customCategoryId)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.day, day) || other.day == day)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.time, time) || other.time == time)&&(identical(other.repeatYearly, repeatYearly) || other.repeatYearly == repeatYearly)&&const DeepCollectionEquality().equals(other.remindDaysBefore, _remindDaysBefore)&&(identical(other.notifyTime, notifyTime) || other.notifyTime == notifyTime)&&(identical(other.alarmEnabled, alarmEnabled) || other.alarmEnabled == alarmEnabled)&&(identical(other.smsMode, smsMode) || other.smsMode == smsMode)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.smsText, smsText) || other.smsText == smsText)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,personName,category,customCategoryId,emoji,day,month,year,time,repeatYearly,const DeepCollectionEquality().hash(_remindDaysBefore),notifyTime,alarmEnabled,smsMode,phone,smsText,note);
}

@override
String toString() {
    return 'ImportantEvent(id: $id, title: $title, personName: $personName, category: $category, customCategoryId: $customCategoryId, emoji: $emoji, day: $day, month: $month, year: $year, time: $time, repeatYearly: $repeatYearly, remindDaysBefore: $remindDaysBefore, notifyTime: $notifyTime, alarmEnabled: $alarmEnabled, smsMode: $smsMode, phone: $phone, smsText: $smsText, note: $note)';
}


}

/// @nodoc
abstract mixin class _$ImportantEventCopyWith<$Res> implements $ImportantEventCopyWith<$Res> {
  factory _$ImportantEventCopyWith(_ImportantEvent value, $Res Function(_ImportantEvent) _then) = __$ImportantEventCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false, includeFromJson: false) String id, String title, String? personName,@JsonKey(unknownEnumValue: EventCategory.other) EventCategory category, String? customCategoryId, String emoji, int day, int month, int? year, String? time, bool repeatYearly, List<int> remindDaysBefore, String notifyTime, bool alarmEnabled,@JsonKey(unknownEnumValue: SmsMode.off) SmsMode smsMode, String? phone, String? smsText, String? note
});




}
/// @nodoc
class __$ImportantEventCopyWithImpl<$Res>
    implements _$ImportantEventCopyWith<$Res> {
  __$ImportantEventCopyWithImpl(this._self, this._then);

  final _ImportantEvent _self;
  final $Res Function(_ImportantEvent) _then;

/// Create a copy of ImportantEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? personName = freezed,Object? category = null,Object? customCategoryId = freezed,Object? emoji = null,Object? day = null,Object? month = null,Object? year = freezed,Object? time = freezed,Object? repeatYearly = null,Object? remindDaysBefore = null,Object? notifyTime = null,Object? alarmEnabled = null,Object? smsMode = null,Object? phone = freezed,Object? smsText = freezed,Object? note = freezed,}) {
  return _then(_ImportantEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,personName: freezed == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,customCategoryId: freezed == customCategoryId ? _self.customCategoryId : customCategoryId // ignore: cast_nullable_to_non_nullable
as String?,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,repeatYearly: null == repeatYearly ? _self.repeatYearly : repeatYearly // ignore: cast_nullable_to_non_nullable
as bool,remindDaysBefore: null == remindDaysBefore ? _self._remindDaysBefore : remindDaysBefore // ignore: cast_nullable_to_non_nullable
as List<int>,notifyTime: null == notifyTime ? _self.notifyTime : notifyTime // ignore: cast_nullable_to_non_nullable
as String,alarmEnabled: null == alarmEnabled ? _self.alarmEnabled : alarmEnabled // ignore: cast_nullable_to_non_nullable
as bool,smsMode: null == smsMode ? _self.smsMode : smsMode // ignore: cast_nullable_to_non_nullable
as SmsMode,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,smsText: freezed == smsText ? _self.smsText : smsText // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
