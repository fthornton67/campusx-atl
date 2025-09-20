// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  providerId: json['providerId'] as String,
  serviceId: json['serviceId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  status:
      $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
      OrderStatus.pending,
  paymentStatus:
      $enumDecodeNullable(_$PaymentStatusEnumMap, json['paymentStatus']) ??
      PaymentStatus.pending,
  createdAt: DateTime.parse(json['createdAt'] as String),
  acceptedAt: json['acceptedAt'] == null
      ? null
      : DateTime.parse(json['acceptedAt'] as String),
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  cancelledAt: json['cancelledAt'] == null
      ? null
      : DateTime.parse(json['cancelledAt'] as String),
  cancellationReason: json['cancellationReason'] as String?,
  location: json['location'] as Map<String, dynamic>?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  notes: json['notes'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  review: json['review'] as String?,
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'providerId': instance.providerId,
  'serviceId': instance.serviceId,
  'title': instance.title,
  'description': instance.description,
  'totalAmount': instance.totalAmount,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'acceptedAt': instance.acceptedAt?.toIso8601String(),
  'startedAt': instance.startedAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'cancelledAt': instance.cancelledAt?.toIso8601String(),
  'cancellationReason': instance.cancellationReason,
  'location': instance.location,
  'metadata': instance.metadata,
  'notes': instance.notes,
  'rating': instance.rating,
  'review': instance.review,
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.accepted: 'accepted',
  OrderStatus.inProgress: 'inProgress',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.disputed: 'disputed',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.paid: 'paid',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.failed: 'failed',
};
