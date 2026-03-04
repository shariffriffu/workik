import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/json_loader_service.dart';
import '../utils/json_widget_builder.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageData = JsonLoaderService.instance.getPage('dashboard');
    final children = pageData['children'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(pageData['appBarTitle'] ?? 'Dashboard'),
        backgroundColor: const Color(0xFF4ECDC4),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
            ],
          ),
        ),
        child: Column(
          children: children.map((childJson) {
            return Expanded(
              child: SingleChildScrollView(
                child: JsonWidgetBuilder.buildWidget(
                  context,
                  childJson as Map<String, dynamic>,
                  () => _handleNavigation(childJson['onTap']),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF16213E),
        selectedItemColor: const Color(0xFF4ECDC4),
        unselectedItemColor: const Color(0xFF999999),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _handleBottomNavigation(index);
        },
      ),
    );
  }

  void _handleNavigation(String? action) {
    if (action == null) return;

    switch (action) {
      case 'goto_profile':
        context.go('/profile');
        break;
      case 'goto_settings':
        context.go('/settings');
        break;
      case 'goto_notifications':
        context.go('/notifications');
        break;
      case 'logout_user':
        _showLogoutDialog();
        break;
      default:
        break;
    }
  }

  void _handleBottomNavigation(int index) {
    switch (index) {
      case 0:
        // Stay on dashboard
        break;
      case 1:
        context.go('/notifications');
        break;
      case 2:
        context.go('/settings');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
