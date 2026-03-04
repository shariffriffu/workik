import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/json_loader_service.dart';
import '../utils/json_widget_builder.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final pageData = JsonLoaderService.instance.getPage('settings');
    final children = pageData['children'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(pageData['appBarTitle'] ?? 'Settings'),
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
      case 'change_password':
        _showSnackBar('Change password not implemented yet');
        break;
      case 'setup_2fa':
        _showSnackBar('2FA setup not implemented yet');
        break;
      case 'view_privacy_policy':
        _showSnackBar('Privacy policy not implemented yet');
        break;
      default:
        break;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
