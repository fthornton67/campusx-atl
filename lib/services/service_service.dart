import 'dart:async';
import '../models/service.dart';
import 'mock_data_service.dart';

class ServiceService {
  final StreamController<List<Service>> _servicesController = StreamController<List<Service>>.broadcast();
  final StreamController<List<Service>> _categoryServicesController = StreamController<List<Service>>.broadcast();

  ServiceService() {
    // Initialize with mock data
    _servicesController.add(MockDataService.getServices());
  }

  Stream<List<Service>> getServicesByCategory(ServiceCategory category) {
    _categoryServicesController.add(MockDataService.getServicesByCategory(category.name));
    return _categoryServicesController.stream;
  }

  Stream<List<Service>> getAllServices() {
    return _servicesController.stream;
  }

  Stream<List<Service>> getServicesByProvider(String providerId) {
    final services = MockDataService.getServices().where((s) => s.providerId == providerId).toList();
    return Stream.value(services);
  }

  Future<Service?> getServiceById(String serviceId) async {
    return MockDataService.getServiceById(serviceId);
  }

  Future<void> createService(Service service) async {
    // In a real app, this would save to Firestore
    // For now, just add to mock data
    final services = MockDataService.getServices();
    services.add(service);
    _servicesController.add(services);
  }

  Future<void> updateService(Service service) async {
    // In a real app, this would update Firestore
    // For now, just update mock data
    final services = MockDataService.getServices();
    final index = services.indexWhere((s) => s.id == service.id);
    if (index != -1) {
      services[index] = service;
      _servicesController.add(services);
    }
  }

  Future<void> deleteService(String serviceId) async {
    // In a real app, this would delete from Firestore
    // For now, just remove from mock data
    final services = MockDataService.getServices();
    services.removeWhere((s) => s.id == serviceId);
    _servicesController.add(services);
  }

  Future<List<Service>> searchServices(String query) async {
    final services = MockDataService.getServices();
    return services.where((service) =>
        service.name.toLowerCase().contains(query.toLowerCase()) ||
        service.description.toLowerCase().contains(query.toLowerCase()) ||
        service.categoryDisplayName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  void dispose() {
    _servicesController.close();
    _categoryServicesController.close();
  }
}
