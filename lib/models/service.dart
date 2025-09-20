import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

enum ServiceCategory {
  foodDelivery,
  laundry,
  tutoring,
  transportation,
  cleaning,
  maintenance,
  techSupport,
  printing,
  other
}

enum ServiceStatus { available, busy, offline }

@JsonSerializable()
class Service {
  final String id;
  final String providerId;
  final String name;
  final String description;
  final ServiceCategory category;
  final double basePrice;
  final String? imageUrl;
  final List<String> tags;
  final ServiceStatus status;
  final double rating;
  final int totalRatings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final Map<String, dynamic>? metadata; // For category-specific data

  const Service({
    required this.id,
    required this.providerId,
    required this.name,
    required this.description,
    required this.category,
    required this.basePrice,
    this.imageUrl,
    this.tags = const [],
    this.status = ServiceStatus.available,
    this.rating = 0.0,
    this.totalRatings = 0,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.metadata,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  String get categoryDisplayName {
    switch (category) {
      case ServiceCategory.foodDelivery:
        return 'Food Delivery';
      case ServiceCategory.laundry:
        return 'Laundry';
      case ServiceCategory.tutoring:
        return 'Tutoring';
      case ServiceCategory.transportation:
        return 'Transportation';
      case ServiceCategory.cleaning:
        return 'Cleaning';
      case ServiceCategory.maintenance:
        return 'Maintenance';
      case ServiceCategory.techSupport:
        return 'Tech Support';
      case ServiceCategory.printing:
        return 'Printing';
      case ServiceCategory.other:
        return 'Other';
    }
  }
}
