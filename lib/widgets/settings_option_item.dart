import 'package:flutter/material.dart';

class SettingsOptionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback? onTap;

  const SettingsOptionItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        _getIconData(icon),
        color: const Color(0xFF4ECDC4),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFFE0E0E0),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFF4ECDC4),
      ),
      onTap: onTap,
    );
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'lock': Icons.lock,
      'verified': Icons.verified,
      'privacy': Icons.privacy_tip,
      'info': Icons.info,
      'settings': Icons.settings,
    };
    return icons[iconName] ?? Icons.help;
  }
}
