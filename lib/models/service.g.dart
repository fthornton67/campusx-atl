// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
  id: json['id'] as String,
  providerId: json['providerId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  category: $enumDecode(_$ServiceCategoryEnumMap, json['category']),
  basePrice: (json['basePrice'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  status:
      $enumDecodeNullable(_$ServiceStatusEnumMap, json['status']) ??
      ServiceStatus.available,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isActive: json['isActive'] as bool? ?? true,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
  'id': instance.id,
  'providerId': instance.providerId,
  'name': instance.name,
  'description': instance.description,
  'category': _$ServiceCategoryEnumMap[instance.category]!,
  'basePrice': instance.basePrice,
  'imageUrl': instance.imageUrl,
  'tags': instance.tags,
  'status': _$ServiceStatusEnumMap[instance.status]!,
  'rating': instance.rating,
  'totalRatings': instance.totalRatings,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'isActive': instance.isActive,
  'metadata': instance.metadata,
};

const _$ServiceCategoryEnumMap = {
  ServiceCategory.foodDelivery: 'foodDelivery',
  ServiceCategory.laundry: 'laundry',
  ServiceCategory.tutoring: 'tutoring',
  ServiceCategory.transportation: 'transportation',
  ServiceCategory.cleaning: 'cleaning',
  ServiceCategory.maintenance: 'maintenance',
  ServiceCategory.techSupport: 'techSupport',
  ServiceCategory.printing: 'printing',
  ServiceCategory.other: 'other',
};

const _$ServiceStatusEnumMap = {
  ServiceStatus.available: 'available',
  ServiceStatus.busy: 'busy',
  ServiceStatus.offline: 'offline',
};
