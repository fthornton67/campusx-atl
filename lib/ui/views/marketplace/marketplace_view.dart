import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/service.dart';
import '../../../services/service_service.dart';
import '../profile/profile_view.dart';
import '../orders/orders_view.dart';
import '../chat/chat_list_view.dart';
import '../service/service_detail_view.dart';
import 'widgets/service_category_card.dart';
import 'widgets/service_card.dart';
import 'widgets/search_bar_widget.dart';

class MarketplaceView extends ConsumerStatefulWidget {
  const MarketplaceView({super.key});

  @override
  ConsumerState<MarketplaceView> createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends ConsumerState<MarketplaceView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MarketplaceHomePage(),
    const OrdersView(),
    const ChatListView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class MarketplaceHomePage extends ConsumerStatefulWidget {
  const MarketplaceHomePage({super.key});

  @override
  ConsumerState<MarketplaceHomePage> createState() => _MarketplaceHomePageState();
}

class _MarketplaceHomePageState extends ConsumerState<MarketplaceHomePage> {
  final ServiceService _serviceService = ServiceService();
  String _searchQuery = '';
  ServiceCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusXATL'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          
          // Category Selection
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ServiceCategory.values.length,
              itemBuilder: (context, index) {
                final category = ServiceCategory.values[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ServiceCategoryCard(
                    category: category,
                    isSelected: _selectedCategory == category,
                    onTap: () {
                      setState(() {
                        _selectedCategory = _selectedCategory == category ? null : category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Services List
          Expanded(
            child: _buildServicesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create service page
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildServicesList() {
    if (_searchQuery.isNotEmpty) {
      return FutureBuilder<List<Service>>(
        future: _serviceService.searchServices(_searchQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final services = snapshot.data ?? [];
          return _buildServicesGrid(services);
        },
      );
    }

    if (_selectedCategory != null) {
      return StreamBuilder<List<Service>>(
        stream: _serviceService.getServicesByCategory(_selectedCategory!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final services = snapshot.data ?? [];
          return _buildServicesGrid(services);
        },
      );
    }

    return StreamBuilder<List<Service>>(
      stream: _serviceService.getAllServices(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final services = snapshot.data ?? [];
        return _buildServicesGrid(services);
      },
    );
  }

  Widget _buildServicesGrid(List<Service> services) {
    if (services.isEmpty) {
      return const Center(
        child: Text(
          'No services available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCard(
          service: service,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceDetailView(serviceId: service.id),
              ),
            );
          },
        );
      },
    );
  }
}
