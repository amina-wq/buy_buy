import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

enum Gender {
  male,
  female,
  @JsonValue('')
  unknown,
  other,
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class Profile {
  @JsonKey(name: 'documentID')
  final String id;

  final String name;
  final String email;
  final String phone;
  final Gender gender;

  @TimestampConverter()
  final DateTime dateOfBirth;
  @JsonKey(name: 'avatar')
  final String avatarUrl;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
