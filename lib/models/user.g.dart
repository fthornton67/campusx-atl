// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
  userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
  phoneNumber: json['phoneNumber'] as String?,
  studentId: json['studentId'] as String?,
  major: json['major'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  totalRatings: (json['totalRatings'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isActive: json['isActive'] as bool? ?? true,
  isVerified: json['isVerified'] as bool? ?? false,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profileImageUrl': instance.profileImageUrl,
  'userType': _$UserTypeEnumMap[instance.userType]!,
  'phoneNumber': instance.phoneNumber,
  'studentId': instance.studentId,
  'major': instance.major,
  'rating': instance.rating,
  'totalRatings': instance.totalRatings,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'isActive': instance.isActive,
  'isVerified': instance.isVerified,
};

const _$UserTypeEnumMap = {
  UserType.student: 'student',
  UserType.serviceProvider: 'serviceProvider',
  UserType.admin: 'admin',
};
