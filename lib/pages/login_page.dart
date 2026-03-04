import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/json_loader_service.dart';
import '../utils/json_widget_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final validation = JsonLoaderService.instance.getValidation('login');
    for (var key in validation.keys) {
      _controllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginPageData = JsonLoaderService.instance.getPage('login');
    final children = loginPageData['children'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: children.map((childJson) {
                return JsonWidgetBuilder.buildWidget(
                  context,
                  childJson as Map<String, dynamic>,
                  () => _handleNavigation(childJson['onTapAction'] ?? childJson['onPressed']),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(String? action) {
    if (action == null) return;

    switch (action) {
      case 'goto_forgot_password':
        context.go('/forgot-password');
        break;
      case 'login_user':
        _validateAndLogin();
        break;
      case 'authenticateWithBiometrics':
        _showSnackBar('Biometric authentication not implemented yet');
        break;
      case 'goto_settings':
        context.go('/settings');
        break;
      default:
        break;
    }
  }

  void _validateAndLogin() {
    final validation = JsonLoaderService.instance.getValidation('login');
    bool isValid = true;

    for (var key in validation.keys) {
      final controller = _controllers[key];
      final rules = validation[key];
      final regex = rules['regex'];
      final errorMessage = rules['errorMessage'];

      if (controller != null) {
        if (!RegExp(regex).hasMatch(controller.text)) {
          isValid = false;
          _showSnackBar(errorMessage);
        }
      }
    }

    if (isValid) {
      _showSnackBar('Login successful!');
      Future.delayed(const Duration(seconds: 1), () {
        context.go('/dashboard');
      });
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
