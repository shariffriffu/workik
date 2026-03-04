import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/json_loader_service.dart';
import '../utils/json_widget_builder.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final validation = JsonLoaderService.instance.getValidation('forgotPassword');
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
    final pageData = JsonLoaderService.instance.getPage('forgotPassword');
    final children = pageData['children'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(pageData['appBarTitle'] ?? 'Forgot Password'),
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
      case 'send_reset_link':
        _validateAndSendReset();
        break;
      case 'goto_login':
        context.go('/login');
        break;
      default:
        break;
    }
  }

  void _validateAndSendReset() {
    final validation = JsonLoaderService.instance.getValidation('forgotPassword');
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
      _showSnackBar('Password reset link sent to your email!');
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/login');
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
