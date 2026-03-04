import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsToggleItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String icon;
  final String settingKey;

  const SettingsToggleItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.settingKey,
  }) : super(key: key);

  @override
  State<SettingsToggleItem> createState() => _SettingsToggleItemState();
}

class _SettingsToggleItemState extends State<SettingsToggleItem> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        _getIconData(widget.icon),
        color: const Color(0xFF4ECDC4),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFFE0E0E0),
        ),
      ),
      trailing: Switch(
        value: _isEnabled,
        onChanged: (value) {
          setState(() {
            _isEnabled = value;
          });
          if (widget.settingKey == 'darkMode') {
            context.read<ThemeProvider>().toggleTheme();
          }
        },
        activeColor: const Color(0xFF4ECDC4),
        activeTrackColor: const Color(0xFF4ECDC4).withOpacity(0.3),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'dark_mode': Icons.dark_mode,
      'notifications': Icons.notifications,
      'mail': Icons.mail,
      'settings': Icons.settings,
    };
    return icons[iconName] ?? Icons.help;
  }
}
