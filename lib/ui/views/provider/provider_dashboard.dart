import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/service.dart';
import '../../../models/order.dart' as app_models;
import '../../../models/user.dart' as app_models_user;
import '../../../services/service_service.dart';
import '../../../services/order_service.dart';
import '../../../services/auth_service.dart';
import 'widgets/service_management_card.dart';
import 'widgets/order_management_card.dart';
import 'widgets/earnings_card.dart';

class ProviderDashboard extends ConsumerStatefulWidget {
  const ProviderDashboard({super.key});

  @override
  ConsumerState<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends ConsumerState<ProviderDashboard> with TickerProviderStateMixin {
  final ServiceService _serviceService = ServiceService();
  final OrderService _orderService = OrderService();
  final AuthService _authService = AuthService();
  late TabController _tabController;
  app_models_user.User? _currentUser;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _authService.getCurrentUserData();
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading user data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Provider Dashboard'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Services'),
            Tab(text: 'Orders'),
            Tab(text: 'Earnings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildServicesTab(),
          _buildOrdersTab(),
          _buildEarningsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateServiceDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildServicesTab() {
    return FutureBuilder<String?>(
      future: Future.value(_authService.currentUser?.uid),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) {
          return const Center(child: Text('Please sign in'));
        }

        return StreamBuilder<List<Service>>(
          stream: _serviceService.getServicesByProvider(userSnapshot.data!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final services = snapshot.data ?? [];

            if (services.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business_center_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No services yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create your first service to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ServiceManagementCard(
                    service: service,
                    onEdit: () {
                      _showEditServiceDialog(service);
                    },
                    onToggleStatus: () {
                      _toggleServiceStatus(service);
                    },
                    onDelete: () {
                      _deleteService(service);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildOrdersTab() {
    return FutureBuilder<String?>(
      future: Future.value(_authService.currentUser?.uid),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) {
          return const Center(child: Text('Please sign in'));
        }

        return StreamBuilder<List<app_models.Order>>(
          stream: _orderService.getActiveOrdersByProvider(userSnapshot.data!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final orders = snapshot.data ?? [];

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No active orders',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OrderManagementCard(
                    order: order,
                    onAccept: () => _updateOrderStatus(order, app_models.OrderStatus.accepted),
                    onStart: () => _updateOrderStatus(order, app_models.OrderStatus.inProgress),
                    onComplete: () => _updateOrderStatus(order, app_models.OrderStatus.completed),
                    onCancel: () => _cancelOrder(order),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEarningsTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          EarningsCard(),
          SizedBox(height: 16),
          // TODO: Add earnings chart and detailed breakdown
        ],
      ),
    );
  }

  void _showCreateServiceDialog() {
    // TODO: Implement create service dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create service dialog coming soon')),
    );
  }

  void _showEditServiceDialog(Service service) {
    // TODO: Implement edit service dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit service dialog coming soon')),
    );
  }

  Future<void> _toggleServiceStatus(Service service) async {
    try {
      final updatedService = Service(
        id: service.id,
        providerId: service.providerId,
        name: service.name,
        description: service.description,
        category: service.category,
        basePrice: service.basePrice,
        imageUrl: service.imageUrl,
        tags: service.tags,
        status: service.status == ServiceStatus.available 
            ? ServiceStatus.offline 
            : ServiceStatus.available,
        rating: service.rating,
        totalRatings: service.totalRatings,
        createdAt: service.createdAt,
        updatedAt: DateTime.now(),
        isActive: service.isActive,
        metadata: service.metadata,
      );

      await _serviceService.updateService(updatedService);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating service: $e')),
        );
      }
    }
  }

  Future<void> _deleteService(Service service) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: const Text('Are you sure you want to delete this service?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _serviceService.deleteService(service.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Service deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting service: $e')),
          );
        }
      }
    }
  }

  Future<void> _updateOrderStatus(app_models.Order order, app_models.OrderStatus status) async {
    try {
      await _orderService.updateOrderStatus(order.id, status);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order ${status.name} successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating order: $e')),
        );
      }
    }
  }

  Future<void> _cancelOrder(app_models.Order order) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please provide a reason for cancellation:'),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (reason != null && reason.isNotEmpty) {
      try {
        await _orderService.updateOrderStatus(order.id, app_models.OrderStatus.cancelled, reason: reason);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order cancelled successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error cancelling order: $e')),
          );
        }
      }
    }
  }
}
