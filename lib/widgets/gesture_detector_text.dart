import 'package:flutter/material.dart';
import '../services/json_loader_service.dart';
import '../utils/color_utils.dart';

class GestureDetectorText extends StatelessWidget {
  final String text;
  final String? onTapAction;
  final VoidCallback? onTap;
  final String? alignment;
  final String? textStyle;

  const GestureDetectorText({
    Key? key,
    required this.text,
    this.onTapAction,
    this.onTap,
    this.alignment,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleData = textStyle != null
        ? JsonLoaderService.instance.getTextStyle(textStyle!)
        : {};

    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    if (alignment == 'end') {
      mainAxisAlignment = MainAxisAlignment.end;
    } else if (alignment == 'center') {
      mainAxisAlignment = MainAxisAlignment.center;
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              text,
              style: TextStyle(
                fontSize: (styleData['fontSize'] as num?)?.toDouble() ?? 12,
                fontWeight: _parseFontWeight(styleData['fontWeight']),
                color: _parseColor(styleData['color'] ?? '#4ECDC4'),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _parseColor(dynamic colorValue) {
    if (colorValue is String) {
      return ColorUtils.fromHex(colorValue);
    }
    return const Color(0xFF4ECDC4);
  }

  FontWeight _parseFontWeight(dynamic weight) {
    if (weight is String) {
      switch (weight.toLowerCase()) {
        case 'bold':
          return FontWeight.bold;
        default:
          return FontWeight.normal;
      }
    }
    return FontWeight.normal;
  }
}
