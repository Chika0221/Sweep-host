// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Host {

 String get diaplayName; String get email; LatLng get homeLocation; String get photoURL; String get hid;
/// Create a copy of Host
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostCopyWith<Host> get copyWith => _$HostCopyWithImpl<Host>(this as Host, _$identity);

  /// Serializes this Host to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Host&&(identical(other.diaplayName, diaplayName) || other.diaplayName == diaplayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.homeLocation, homeLocation) || other.homeLocation == homeLocation)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.hid, hid) || other.hid == hid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diaplayName,email,homeLocation,photoURL,hid);

@override
String toString() {
  return 'Host(diaplayName: $diaplayName, email: $email, homeLocation: $homeLocation, photoURL: $photoURL, hid: $hid)';
}


}

/// @nodoc
abstract mixin class $HostCopyWith<$Res>  {
  factory $HostCopyWith(Host value, $Res Function(Host) _then) = _$HostCopyWithImpl;
@useResult
$Res call({
 String diaplayName, String email, LatLng homeLocation, String photoURL, String hid
});




}
/// @nodoc
class _$HostCopyWithImpl<$Res>
    implements $HostCopyWith<$Res> {
  _$HostCopyWithImpl(this._self, this._then);

  final Host _self;
  final $Res Function(Host) _then;

/// Create a copy of Host
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? diaplayName = null,Object? email = null,Object? homeLocation = null,Object? photoURL = null,Object? hid = null,}) {
  return _then(_self.copyWith(
diaplayName: null == diaplayName ? _self.diaplayName : diaplayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,homeLocation: null == homeLocation ? _self.homeLocation : homeLocation // ignore: cast_nullable_to_non_nullable
as LatLng,photoURL: null == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String,hid: null == hid ? _self.hid : hid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Host implements Host {
  const _Host({required this.diaplayName, required this.email, required this.homeLocation, required this.photoURL, required this.hid});
  factory _Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

@override final  String diaplayName;
@override final  String email;
@override final  LatLng homeLocation;
@override final  String photoURL;
@override final  String hid;

/// Create a copy of Host
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostCopyWith<_Host> get copyWith => __$HostCopyWithImpl<_Host>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Host&&(identical(other.diaplayName, diaplayName) || other.diaplayName == diaplayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.homeLocation, homeLocation) || other.homeLocation == homeLocation)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.hid, hid) || other.hid == hid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diaplayName,email,homeLocation,photoURL,hid);

@override
String toString() {
  return 'Host(diaplayName: $diaplayName, email: $email, homeLocation: $homeLocation, photoURL: $photoURL, hid: $hid)';
}


}

/// @nodoc
abstract mixin class _$HostCopyWith<$Res> implements $HostCopyWith<$Res> {
  factory _$HostCopyWith(_Host value, $Res Function(_Host) _then) = __$HostCopyWithImpl;
@override @useResult
$Res call({
 String diaplayName, String email, LatLng homeLocation, String photoURL, String hid
});




}
/// @nodoc
class __$HostCopyWithImpl<$Res>
    implements _$HostCopyWith<$Res> {
  __$HostCopyWithImpl(this._self, this._then);

  final _Host _self;
  final $Res Function(_Host) _then;

/// Create a copy of Host
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? diaplayName = null,Object? email = null,Object? homeLocation = null,Object? photoURL = null,Object? hid = null,}) {
  return _then(_Host(
diaplayName: null == diaplayName ? _self.diaplayName : diaplayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,homeLocation: null == homeLocation ? _self.homeLocation : homeLocation // ignore: cast_nullable_to_non_nullable
as LatLng,photoURL: null == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String,hid: null == hid ? _self.hid : hid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
