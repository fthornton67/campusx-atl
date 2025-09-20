import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/order.dart' as app_models;
import '../../../services/order_service.dart';
import '../../../services/auth_service.dart';
import 'widgets/order_card.dart';

class OrdersView extends ConsumerStatefulWidget {
  const OrdersView({super.key});

  @override
  ConsumerState<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView> with TickerProviderStateMixin {
  final OrderService _orderService = OrderService();
  final AuthService _authService = AuthService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(app_models.OrderStatus.pending),
          _buildOrdersList(app_models.OrderStatus.completed),
          _buildOrdersList(app_models.OrderStatus.cancelled),
        ],
      ),
    );
  }

  Widget _buildOrdersList(app_models.OrderStatus status) {
    return FutureBuilder<String?>(
      future: Future.value(_authService.currentUser?.uid),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) {
          return const Center(child: Text('Please sign in to view orders'));
        }

        return StreamBuilder<List<app_models.Order>>(
          stream: _orderService.getOrdersByCustomer(userSnapshot.data!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final orders = snapshot.data ?? [];
            final filteredOrders = orders.where((order) => order.status == status).toList();

            if (filteredOrders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getEmptyStateIcon(status),
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getEmptyStateMessage(status),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OrderCard(
                    order: order,
                    onTap: () {
                      // TODO: Navigate to order details
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

  IconData _getEmptyStateIcon(app_models.OrderStatus status) {
    switch (status) {
      case app_models.OrderStatus.pending:
        return Icons.shopping_bag_outlined;
      case app_models.OrderStatus.completed:
        return Icons.check_circle_outline;
      case app_models.OrderStatus.cancelled:
        return Icons.cancel_outlined;
      default:
        return Icons.shopping_bag_outlined;
    }
  }

  String _getEmptyStateMessage(app_models.OrderStatus status) {
    switch (status) {
      case app_models.OrderStatus.pending:
        return 'No active orders';
      case app_models.OrderStatus.completed:
        return 'No completed orders';
      case app_models.OrderStatus.cancelled:
        return 'No cancelled orders';
      default:
        return 'No orders found';
    }
  }
}
