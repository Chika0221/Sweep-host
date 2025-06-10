// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'host.freezed.dart';
part 'host.g.dart';

@freezed
class Host with _$Host {
  const factory Host({
    required String diaplayName,
    required String email,
    required LatLng homeLocation,
    required String photoURL,
    required String hid,
  }) = _Host;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);
  
  @override
  // TODO: implement diaplayName
  String get diaplayName => throw UnimplementedError();
  
  @override
  // TODO: implement email
  String get email => throw UnimplementedError();
  
  @override
  // TODO: implement hid
  String get hid => throw UnimplementedError();
  
  @override
  // TODO: implement homeLocation
  LatLng get homeLocation => throw UnimplementedError();
  
  @override
  // TODO: implement photoURL
  String get photoURL => throw UnimplementedError();
  
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

}
