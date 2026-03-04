import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/json_loader_service.dart';
import '../utils/json_widget_builder.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final pageData = JsonLoaderService.instance.getPage('notifications');
    final children = pageData['children'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(pageData['appBarTitle'] ?? 'Notifications'),
        backgroundColor: const Color(0xFF4ECDC4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
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
              child: JsonWidgetBuilder.buildWidget(
                context,
                childJson as Map<String, dynamic>,
                () => _handleNavigation(childJson['onTap']),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _handleNavigation(String? action) {
    if (action == null) return;

    switch (action) {
      default:
        break;
    }
  }
}
