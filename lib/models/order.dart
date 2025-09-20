import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

enum OrderStatus {
  pending,
  accepted,
  inProgress,
  completed,
  cancelled,
  disputed
}

enum PaymentStatus { pending, paid, refunded, failed }

@JsonSerializable()
class Order {
  final String id;
  final String customerId;
  final String providerId;
  final String serviceId;
  final String title;
  final String description;
  final double totalAmount;
  final OrderStatus status;
  final PaymentStatus paymentStatus;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final Map<String, dynamic>? location; // Pickup/delivery location
  final Map<String, dynamic>? metadata; // Service-specific data
  final String? notes;
  final double? rating;
  final String? review;

  const Order({
    required this.id,
    required this.customerId,
    required this.providerId,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.totalAmount,
    this.status = OrderStatus.pending,
    this.paymentStatus = PaymentStatus.pending,
    required this.createdAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.location,
    this.metadata,
    this.notes,
    this.rating,
    this.review,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  String get statusDisplayName {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.accepted:
        return 'Accepted';
      case OrderStatus.inProgress:
        return 'In Progress';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.disputed:
        return 'Disputed';
    }
  }

  bool get isActive => status == OrderStatus.pending || 
                      status == OrderStatus.accepted || 
                      status == OrderStatus.inProgress;
}
