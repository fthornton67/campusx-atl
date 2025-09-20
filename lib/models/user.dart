import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum UserType { student, serviceProvider, admin }

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final UserType userType;
  final String? phoneNumber;
  final String? studentId;
  final String? major;
  final double? rating;
  final int? totalRatings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isVerified;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.userType,
    this.phoneNumber,
    this.studentId,
    this.major,
    this.rating,
    this.totalRatings,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get fullName => '$firstName $lastName';
  String get displayName => userType == UserType.student ? '$firstName $lastName' : '$firstName $lastName';
}
