import 'dart:async';
import '../models/order.dart' as app_models;
import 'mock_data_service.dart';

class OrderService {
  final StreamController<List<app_models.Order>> _ordersController = StreamController<List<app_models.Order>>.broadcast();

  OrderService() {
    // Initialize with mock data
    _ordersController.add(MockDataService.getOrdersByCustomer('mock_user_123'));
  }

  Stream<List<app_models.Order>> getOrdersByCustomer(String customerId) {
    return Stream.value(MockDataService.getOrdersByCustomer(customerId));
  }

  Stream<List<app_models.Order>> getOrdersByProvider(String providerId) {
    return Stream.value(MockDataService.getOrdersByProvider(providerId));
  }

  Stream<List<app_models.Order>> getActiveOrdersByProvider(String providerId) {
    return Stream.value(MockDataService.getActiveOrdersByProvider(providerId));
  }

  Future<app_models.Order?> getOrderById(String orderId) async {
    return MockDataService.getOrderById(orderId);
  }

  Future<void> createOrder(app_models.Order order) async {
    MockDataService.addOrder(order);
    _ordersController.add(MockDataService.getOrdersByCustomer('mock_user_123'));
  }

  Future<void> updateOrderStatus(String orderId, app_models.OrderStatus status, {String? reason}) async {
    MockDataService.updateOrderStatus(orderId, status, reason: reason);
    _ordersController.add(MockDataService.getOrdersByCustomer('mock_user_123'));
  }

  Future<void> updateOrderPaymentStatus(String orderId, app_models.PaymentStatus status) async {
    MockDataService.updateOrderPaymentStatus(orderId, status);
    _ordersController.add(MockDataService.getOrdersByCustomer('mock_user_123'));
  }

  Future<void> addOrderReview(String orderId, double rating, String review) async {
    MockDataService.addOrderReview(orderId, rating, review);
    _ordersController.add(MockDataService.getOrdersByCustomer('mock_user_123'));
  }

  void dispose() {
    _ordersController.close();
  }
}
