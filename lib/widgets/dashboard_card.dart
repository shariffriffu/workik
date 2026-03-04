import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String icon;
  final String color;
  final VoidCallback? onTap;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    this.color = '#4ECDC4',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _parseColor(color),
                _parseColor(color).withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconData(icon),
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    return ColorUtils.fromHex(hexColor);
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'person': Icons.person,
      'settings': Icons.settings,
      'notifications': Icons.notifications,
      'logout': Icons.logout,
      'home': Icons.home,
      'info': Icons.info,
    };
    return icons[iconName] ?? Icons.help;
  }
}
