import 'package:flutter/material.dart';
import '../services/json_loader_service.dart';
import '../utils/color_utils.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final String buttonStyleType;

  const CustomButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.buttonStyleType = 'typeLogin',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleData = JsonLoaderService.instance
        .getButtonStyle(buttonStyleType);

    final bgColor = _parseColor(styleData['backgroundColor']);
    final fgColor = _parseColor(styleData['foregroundColor']);
    final padding = (styleData['padding'] as num?)?.toDouble() ?? 16;
    final fontSize = (styleData['fontSize'] as num?)?.toDouble() ?? 16;
    final borderRadius = (styleData['borderRadius'] as num?)?.toDouble() ?? 8;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            padding: EdgeInsets.symmetric(vertical: padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fgColor,
            ),
          ),
        ),
      ),
    );
  }

  Color _parseColor(dynamic colorValue) {
    if (colorValue is String) {
      return ColorUtils.fromHex(colorValue);
    }
    return Colors.white;
  }
}
