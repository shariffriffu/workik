import 'package:flutter/material.dart';
import '../services/json_loader_service.dart';
import '../utils/color_utils.dart';

class CustomTextField extends StatefulWidget {
  final String id;
  final String label;
  final String hintText;
  final bool isPassword;
  final String keyboardType;
  final String? icon;
  final String textFieldPropertyType;

  const CustomTextField({
    Key? key,
    required this.id,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = 'text',
    this.icon,
    this.textFieldPropertyType = 'typeGlass',
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styleData = JsonLoaderService.instance
        .getTextFieldStyle(widget.textFieldPropertyType);

    final bgColor = _parseColor(styleData['backgroundColor']);
    final borderColor = _parseColor(styleData['borderColor']);
    final textColor = _parseColor(styleData['textColor']);
    final hintColor = _parseColor(styleData['hintColor']);
    final labelColor = _parseColor(styleData['labelColor']);
    final borderRadius = (styleData['borderRadius'] as num?)?.toDouble() ?? 8;
    final borderWidth = (styleData['borderWidth'] as num?)?.toDouble() ?? 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _controller,
        obscureText: _obscureText,
        keyboardType: _getKeyboardType(widget.keyboardType),
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: labelColor),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: hintColor),
          filled: true,
          fillColor: bgColor,
          prefixIcon: widget.icon != null ? Icon(
            _getIconData(widget.icon!),
            color: labelColor,
          ) : null,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: labelColor,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: _parseColor(styleData['focusedBorderColor'] ?? '#4ECDC4'),
              width: borderWidth * 2,
            ),
          ),
        ),
      ),
    );
  }

  TextInputType _getKeyboardType(String type) {
    switch (type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'number':
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  Color _parseColor(dynamic colorValue) {
    if (colorValue is String) {
      return ColorUtils.fromHex(colorValue);
    }
    return Colors.white;
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'person': Icons.person,
      'person_outline': Icons.person_outline,
      'lock': Icons.lock,
      'lock_outline': Icons.lock_outline,
      'mail_outline': Icons.mail_outline,
      'mail': Icons.mail,
    };
    return icons[iconName] ?? Icons.help;
  }
}
