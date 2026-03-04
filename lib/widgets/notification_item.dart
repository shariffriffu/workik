import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String timestamp;
  final String icon;
  final String color;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.message,
    required this.timestamp,
    this.icon = 'notifications',
    this.color = '#4ECDC4',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _parseColor(color).withOpacity(0.2),
            ),
            child: Icon(
              _getIconData(icon),
              color: _parseColor(color),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE0E0E0),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String hexColor) {
    return ColorUtils.fromHex(hexColor);
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'notifications': Icons.notifications,
      'system_update': Icons.system_update,
      'security': Icons.security,
      'build': Icons.build,
    };
    return icons[iconName] ?? Icons.help;
  }
}
