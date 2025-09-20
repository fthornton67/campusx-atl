import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/order.dart' as app_models;
import '../../../services/order_service.dart';
import '../../../services/auth_service.dart';
import 'widgets/chat_item_card.dart';

class ChatListView extends ConsumerStatefulWidget {
  const ChatListView({super.key});

  @override
  ConsumerState<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends ConsumerState<ChatListView> {
  final OrderService _orderService = OrderService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<String?>(
        future: Future.value(_authService.currentUser?.uid),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return const Center(child: Text('Please sign in to view messages'));
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
              final activeOrders = orders.where((order) => order.isActive).toList();

              if (activeOrders.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No active conversations',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: activeOrders.length,
                itemBuilder: (context, index) {
                  final order = activeOrders[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ChatItemCard(
                      order: order,
                      onTap: () {
                        // TODO: Navigate to chat screen
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
