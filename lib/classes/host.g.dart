// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Host _$HostFromJson(Map<String, dynamic> json) => _Host(
  displayName: json['displayName'] as String,
  email: json['email'] as String,
  homeLocation: LatLng(
    (json['homeLocation'] as GeoPoint).latitude,
    (json['homeLocation'] as GeoPoint).longitude,
  ),
  photoURL: json['photoURL'] as String,
  hid: json['hid'] as String,
);

Map<String, dynamic> _$HostToJson(_Host instance) => <String, dynamic>{
  'displayName': instance.displayName,
  'email': instance.email,
  'homeLocation': GeoPoint(
    instance.homeLocation.latitude,
    instance.homeLocation.longitude,
  ),
  'photoURL': instance.photoURL,
  'hid': instance.hid,
};
