import 'package:flutter/material.dart';
import '../../../../models/service.dart';

class ServiceCategoryCard extends StatelessWidget {
  final ServiceCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceCategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(category),
              size: 32,
              color: isSelected 
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              _getCategoryDisplayName(category),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected 
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.foodDelivery:
        return Icons.delivery_dining;
      case ServiceCategory.laundry:
        return Icons.local_laundry_service;
      case ServiceCategory.tutoring:
        return Icons.school;
      case ServiceCategory.transportation:
        return Icons.directions_car;
      case ServiceCategory.cleaning:
        return Icons.cleaning_services;
      case ServiceCategory.maintenance:
        return Icons.build;
      case ServiceCategory.techSupport:
        return Icons.computer;
      case ServiceCategory.printing:
        return Icons.print;
      case ServiceCategory.other:
        return Icons.more_horiz;
    }
  }

  String _getCategoryDisplayName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.foodDelivery:
        return 'Food';
      case ServiceCategory.laundry:
        return 'Laundry';
      case ServiceCategory.tutoring:
        return 'Tutoring';
      case ServiceCategory.transportation:
        return 'Ride';
      case ServiceCategory.cleaning:
        return 'Cleaning';
      case ServiceCategory.maintenance:
        return 'Repair';
      case ServiceCategory.techSupport:
        return 'Tech';
      case ServiceCategory.printing:
        return 'Print';
      case ServiceCategory.other:
        return 'Other';
    }
  }
}
