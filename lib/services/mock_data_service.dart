import '../models/service.dart';
import '../models/order.dart' as app_models;

class MockDataService {
  static final List<Service> _mockServices = [
    Service(
      id: '1',
      providerId: 'provider_1',
      name: 'Laundry Service',
      description: 'Pick up and drop off laundry service for students',
      category: ServiceCategory.laundry,
      basePrice: 15.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Laundry',
      tags: ['laundry', 'pickup', 'delivery'],
      rating: 4.5,
      totalRatings: 23,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: '2',
      providerId: 'provider_2',
      name: 'Food Delivery',
      description: 'Delivery from campus dining halls and local restaurants',
      category: ServiceCategory.foodDelivery,
      basePrice: 8.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Food',
      tags: ['food', 'delivery', 'dining'],
      rating: 4.8,
      totalRatings: 45,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: '3',
      providerId: 'provider_3',
      name: 'Tutoring',
      description: 'One-on-one tutoring for various subjects',
      category: ServiceCategory.tutoring,
      basePrice: 25.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Tutoring',
      tags: ['tutoring', 'education', 'academic'],
      rating: 4.9,
      totalRatings: 67,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: '4',
      providerId: 'provider_4',
      name: 'Room Cleaning',
      description: 'Deep cleaning service for dorm rooms',
      category: ServiceCategory.cleaning,
      basePrice: 35.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Cleaning',
      tags: ['cleaning', 'dorm', 'room'],
      rating: 4.6,
      totalRatings: 34,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: '5',
      providerId: 'provider_5',
      name: 'Grocery Shopping',
      description: 'Personal grocery shopping and delivery service',
      category: ServiceCategory.other,
      basePrice: 12.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Grocery',
      tags: ['grocery', 'shopping', 'delivery'],
      rating: 4.7,
      totalRatings: 28,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: '6',
      providerId: 'provider_6',
      name: 'Study Group Organizer',
      description: 'Organize and facilitate study groups for various courses',
      category: ServiceCategory.tutoring,
      basePrice: 20.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Study+Group',
      tags: ['study', 'group', 'academic'],
      rating: 4.8,
      totalRatings: 41,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<app_models.Order> _mockOrders = [
    app_models.Order(
      id: 'order_1',
      customerId: 'mock_user_123',
      providerId: 'provider_1',
      serviceId: '1',
      title: 'Laundry Service',
      description: 'Pick up and drop off laundry service for students',
      totalAmount: 30.0,
      status: app_models.OrderStatus.pending,
      paymentStatus: app_models.PaymentStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    app_models.Order(
      id: 'order_2',
      customerId: 'mock_user_123',
      providerId: 'provider_2',
      serviceId: '2',
      title: 'Food Delivery',
      description: 'Delivery from campus dining halls and local restaurants',
      totalAmount: 8.0,
      status: app_models.OrderStatus.accepted,
      paymentStatus: app_models.PaymentStatus.paid,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      acceptedAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    app_models.Order(
      id: 'order_3',
      customerId: 'mock_user_123',
      providerId: 'provider_3',
      serviceId: '3',
      title: 'Tutoring',
      description: 'One-on-one tutoring for various subjects',
      totalAmount: 50.0,
      status: app_models.OrderStatus.completed,
      paymentStatus: app_models.PaymentStatus.paid,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      acceptedAt: DateTime.now().subtract(const Duration(days: 2)),
      startedAt: DateTime.now().subtract(const Duration(days: 2)),
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      rating: 5.0,
      review: 'Excellent tutoring session!',
    ),
  ];

  static List<Service> getServices() {
    return List.from(_mockServices);
  }

  static List<Service> getServicesByCategory(String category) {
    return _mockServices.where((service) => service.categoryDisplayName == category).toList();
  }

  static Service? getServiceById(String id) {
    try {
      return _mockServices.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<app_models.Order> getOrdersByCustomer(String customerId) {
    return _mockOrders.where((order) => order.customerId == customerId).toList();
  }

  static List<app_models.Order> getOrdersByProvider(String providerId) {
    return _mockOrders.where((order) => order.providerId == providerId).toList();
  }

  static List<app_models.Order> getActiveOrdersByProvider(String providerId) {
    return _mockOrders.where((order) => 
      order.providerId == providerId && 
      (order.status == app_models.OrderStatus.pending || 
       order.status == app_models.OrderStatus.accepted || 
       order.status == app_models.OrderStatus.inProgress)
    ).toList();
  }

  static app_models.Order? getOrderById(String orderId) {
    try {
      return _mockOrders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  static void addOrder(app_models.Order order) {
    _mockOrders.add(order);
  }

  static void updateOrderStatus(String orderId, app_models.OrderStatus status, {String? reason}) {
    final orderIndex = _mockOrders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _mockOrders[orderIndex];
      _mockOrders[orderIndex] = app_models.Order(
        id: order.id,
        customerId: order.customerId,
        providerId: order.providerId,
        serviceId: order.serviceId,
        title: order.title,
        description: order.description,
        totalAmount: order.totalAmount,
        status: status,
        paymentStatus: order.paymentStatus,
        createdAt: order.createdAt,
        acceptedAt: status == app_models.OrderStatus.accepted ? DateTime.now() : order.acceptedAt,
        startedAt: status == app_models.OrderStatus.inProgress ? DateTime.now() : order.startedAt,
        completedAt: status == app_models.OrderStatus.completed ? DateTime.now() : order.completedAt,
        cancelledAt: status == app_models.OrderStatus.cancelled ? DateTime.now() : order.cancelledAt,
        cancellationReason: reason,
        location: order.location,
        metadata: order.metadata,
        notes: order.notes,
        rating: order.rating,
        review: order.review,
      );
    }
  }

  static void updateOrderPaymentStatus(String orderId, app_models.PaymentStatus status) {
    final orderIndex = _mockOrders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _mockOrders[orderIndex];
      _mockOrders[orderIndex] = app_models.Order(
        id: order.id,
        customerId: order.customerId,
        providerId: order.providerId,
        serviceId: order.serviceId,
        title: order.title,
        description: order.description,
        totalAmount: order.totalAmount,
        status: order.status,
        paymentStatus: status,
        createdAt: order.createdAt,
        acceptedAt: order.acceptedAt,
        startedAt: order.startedAt,
        completedAt: order.completedAt,
        cancelledAt: order.cancelledAt,
        cancellationReason: order.cancellationReason,
        location: order.location,
        metadata: order.metadata,
        notes: order.notes,
        rating: order.rating,
        review: order.review,
      );
    }
  }

  static void addOrderReview(String orderId, double rating, String review) {
    final orderIndex = _mockOrders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _mockOrders[orderIndex];
      _mockOrders[orderIndex] = app_models.Order(
        id: order.id,
        customerId: order.customerId,
        providerId: order.providerId,
        serviceId: order.serviceId,
        title: order.title,
        description: order.description,
        totalAmount: order.totalAmount,
        status: order.status,
        paymentStatus: order.paymentStatus,
        createdAt: order.createdAt,
        acceptedAt: order.acceptedAt,
        startedAt: order.startedAt,
        completedAt: order.completedAt,
        cancelledAt: order.cancelledAt,
        cancellationReason: order.cancellationReason,
        location: order.location,
        metadata: order.metadata,
        notes: order.notes,
        rating: rating,
        review: review,
      );
    }
  }
}
