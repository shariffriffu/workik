import 'package:flutter/material.dart';
import '../services/json_loader_service.dart';
import '../utils/color_utils.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/gesture_detector_text.dart';
import '../widgets/profile_detail_field.dart';
import '../widgets/settings_section_header.dart';
import '../widgets/settings_toggle_item.dart';
import '../widgets/settings_option_item.dart';
import '../widgets/notification_item.dart';

class JsonWidgetBuilder {
  static Widget buildWidget(
    BuildContext context,
    Map<String, dynamic> widgetJson,
    VoidCallback? onNavigate,
  ) {
    final String type = widgetJson['type'] ?? 'SizedBox';
    final Map<String, dynamic>? properties = widgetJson;

    switch (type) {
      case 'SizedBox':
        return _buildSizedBox(properties);
      case 'TextField':
        return _buildTextField(properties);
      case 'Button':
        return _buildButton(properties, onNavigate);
      case 'Text':
        return _buildText(properties);
      case 'Center':
        return _buildCenter(context, properties, onNavigate);
      case 'Container':
        return _buildContainer(context, properties, onNavigate);
      case 'Column':
        return _buildColumn(context, properties, onNavigate);
      case 'Row':
        return _buildRow(context, properties, onNavigate);
      case 'Card':
        return _buildCard(context, properties, onNavigate);
      case 'GestureDetectorText':
        return _buildGestureDetectorText(properties, onNavigate);
      case 'GestureDetectorIcon':
        return _buildGestureDetectorIcon(properties, onNavigate);
      case 'CircleAvatar':
        return _buildCircleAvatar(context, properties, onNavigate);
      case 'Icon':
        return _buildIcon(properties);
      case 'DashboardCard':
        return _buildDashboardCard(properties, onNavigate);
      case 'GridView':
        return _buildGridView(context, properties, onNavigate);
      case 'SingleChildScrollView':
        return _buildSingleChildScrollView(context, properties, onNavigate);
      case 'ProfileDetailField':
        return _buildProfileDetailField(properties);
      case 'SettingsSectionHeader':
        return _buildSettingsSectionHeader(properties);
      case 'SettingsToggleItem':
        return _buildSettingsToggleItem(properties);
      case 'SettingsOptionItem':
        return _buildSettingsOptionItem(properties, onNavigate);
      case 'NotificationItem':
        return _buildNotificationItem(properties);
      default:
        return const SizedBox();
    }
  }

  static Widget _buildSizedBox(Map<String, dynamic>? props) {
    final double? height = (props?['height'] as num?)?.toDouble();
    final double? width = (props?['width'] as num?)?.toDouble();
    return SizedBox(height: height, width: width);
  }

  static Widget _buildTextField(Map<String, dynamic>? props) {
    return CustomTextField(
      id: props?['id'] ?? '',
      label: props?['label'] ?? '',
      hintText: props?['hintText'] ?? '',
      isPassword: props?['isPassword'] ?? false,
      keyboardType: props?['keyboardType'] ?? 'text',
      icon: props?['icon'],
      textFieldPropertyType: props?['textFieldPropertyType'] ?? 'typeGlass',
    );
  }

  static Widget _buildButton(
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    return CustomButton(
      label: props?['label'] ?? 'Button',
      onPressed: onNavigate,
      buttonStyleType: props?['buttonStyleType'] ?? 'typeLogin',
    );
  }

  static Widget _buildText(Map<String, dynamic>? props) {
    final String text = props?['text'] ?? '';
    final String textStyle = props?['textStyle'] ?? 'body';
    final String alignment = props?['alignment'] ?? 'start';

    TextAlign textAlign = TextAlign.start;
    if (alignment == 'center') {
      textAlign = TextAlign.center;
    } else if (alignment == 'end') {
      textAlign = TextAlign.end;
    }

    final textStyleData = JsonLoaderService.instance.getTextStyle(textStyle);
    
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: (textStyleData['fontSize'] as num?)?.toDouble() ?? 14,
        fontWeight: _parseFontWeight(textStyleData['fontWeight']),
        color: _parseColor(textStyleData['color']),
      ),
    );
  }

  static Widget _buildCenter(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final Map<String, dynamic>? child = props?['child'];
    final Widget childWidget = child != null
        ? buildWidget(context, child, onNavigate)
        : const SizedBox();

    return Center(child: childWidget);
  }

  static Widget _buildContainer(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final Map<String, dynamic>? paddingMap = props?['padding'];
    final EdgeInsets padding = _parsePadding(paddingMap);
    final Map<String, dynamic>? child = props?['child'];
    
    final Widget childWidget = child != null
        ? buildWidget(context, child, onNavigate)
        : const SizedBox();

    return Container(
      padding: padding,
      child: childWidget,
    );
  }

  static Widget _buildColumn(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final List<dynamic> children = props?['children'] ?? [];
    final List<Widget> widgets = children
        .map((child) => buildWidget(context, child, onNavigate))
        .toList();

    return Column(children: widgets);
  }

  static Widget _buildRow(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final List<dynamic> children = props?['children'] ?? [];
    final List<Widget> widgets = children
        .map((child) => buildWidget(context, child, onNavigate))
        .toList();

    return Row(children: widgets);
  }

  static Widget _buildCard(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final double elevation = (props?['elevation'] as num?)?.toDouble() ?? 4;
    final double padding = (props?['padding'] as num?)?.toDouble() ?? 0;
    final Map<String, dynamic>? child = props?['child'];

    final Widget childWidget = child != null
        ? buildWidget(context, child, onNavigate)
        : const SizedBox();

    return Card(
      elevation: elevation,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: childWidget,
      ),
    );
  }

  static Widget _buildGestureDetectorText(
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    return GestureDetectorText(
      text: props?['text'] ?? '',
      onTapAction: props?['onTapAction'],
      onTap: onNavigate,
      alignment: props?['alignment'],
      textStyle: props?['textStyle'],
    );
  }

  static Widget _buildGestureDetectorIcon(
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final String icon = props?['icon'] ?? '0xe14b';
    final double size = (props?['size'] as num?)?.toDouble() ?? 24;
    final String color = props?['color'] ?? '#FFFFFF';

    return GestureDetector(
      onTap: onNavigate,
      child: Icon(
        IconData(
          int.parse(icon),
          fontFamily: 'MaterialIcons',
        ),
        size: size,
        color: _parseColor(color),
      ),
    );
  }

  static Widget _buildCircleAvatar(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final double radius = (props?['radius'] as num?)?.toDouble() ?? 20;
    final String backgroundColor = props?['backgroundColor'] ?? '#4ECDC4';
    final Map<String, dynamic>? child = props?['child'];

    final Widget childWidget = child != null
        ? buildWidget(context, child, onNavigate)
        : const SizedBox();

    return CircleAvatar(
      radius: radius,
      backgroundColor: _parseColor(backgroundColor),
      child: childWidget,
    );
  }

  static Widget _buildIcon(Map<String, dynamic>? props) {
    final String icon = props?['icon'] ?? 'person';
    final double size = (props?['size'] as num?)?.toDouble() ?? 24;
    final String color = props?['color'] ?? '#FFFFFF';

    return Icon(
      _getIconData(icon),
      size: size,
      color: _parseColor(color),
    );
  }

  static Widget _buildDashboardCard(
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    return DashboardCard(
      title: props?['title'] ?? '',
      icon: props?['icon'] ?? 'home',
      color: props?['color'] ?? '#4ECDC4',
      onTap: onNavigate,
    );
  }

  static Widget _buildGridView(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final int crossAxisCount = props?['crossAxisCount'] ?? 2;
    final List<dynamic> children = props?['children'] ?? [];

    final List<Widget> widgets = children
        .map((child) => buildWidget(context, child, onNavigate))
        .toList();

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: widgets,
    );
  }

  static Widget _buildSingleChildScrollView(
    BuildContext context,
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    final Map<String, dynamic>? child = props?['child'];

    final Widget childWidget = child != null
        ? buildWidget(context, child, onNavigate)
        : const SizedBox();

    return SingleChildScrollView(child: childWidget);
  }

  static Widget _buildProfileDetailField(Map<String, dynamic>? props) {
    return ProfileDetailField(
      label: props?['label'] ?? '',
      value: props?['value'] ?? '',
    );
  }

  static Widget _buildSettingsSectionHeader(Map<String, dynamic>? props) {
    return SettingsSectionHeader(
      title: props?['title'] ?? '',
    );
  }

  static Widget _buildSettingsToggleItem(Map<String, dynamic>? props) {
    return SettingsToggleItem(
      title: props?['title'] ?? '',
      subtitle: props?['subtitle'] ?? '',
      icon: props?['icon'] ?? 'settings',
      settingKey: props?['settingKey'] ?? '',
    );
  }

  static Widget _buildSettingsOptionItem(
    Map<String, dynamic>? props,
    VoidCallback? onNavigate,
  ) {
    return SettingsOptionItem(
      title: props?['title'] ?? '',
      subtitle: props?['subtitle'] ?? '',
      icon: props?['icon'] ?? 'settings',
      onTap: onNavigate,
    );
  }

  static Widget _buildNotificationItem(Map<String, dynamic>? props) {
    return NotificationItem(
      title: props?['title'] ?? '',
      message: props?['message'] ?? '',
      timestamp: props?['timestamp'] ?? '',
      icon: props?['icon'] ?? 'notifications',
      color: props?['color'] ?? '#4ECDC4',
    );
  }

  static Color _parseColor(dynamic colorValue) {
    if (colorValue is String) {
      return ColorUtils.fromHex(colorValue);
    }
    return Colors.white;
  }

  static FontWeight _parseFontWeight(dynamic weight) {
    if (weight is String) {
      switch (weight.toLowerCase()) {
        case 'bold':
          return FontWeight.bold;
        case 'w900':
          return FontWeight.w900;
        case 'w800':
          return FontWeight.w800;
        case 'w700':
          return FontWeight.w700;
        case 'w600':
          return FontWeight.w600;
        default:
          return FontWeight.normal;
      }
    }
    return FontWeight.normal;
  }

  static EdgeInsets _parsePadding(Map<String, dynamic>? paddingMap) {
    if (paddingMap == null) return EdgeInsets.zero;

    if (paddingMap.containsKey('all')) {
      final double all = (paddingMap['all'] as num?)?.toDouble() ?? 0;
      return EdgeInsets.all(all);
    }

    final double left = (paddingMap['left'] as num?)?.toDouble() ?? 0;
    final double top = (paddingMap['top'] as num?)?.toDouble() ?? 0;
    final double right = (paddingMap['right'] as num?)?.toDouble() ?? 0;
    final double bottom = (paddingMap['bottom'] as num?)?.toDouble() ?? 0;

    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  static IconData _getIconData(String iconName) {
    final icons = {
      'person': Icons.person,
      'person_outline': Icons.person_outline,
      'lock': Icons.lock,
      'lock_outline': Icons.lock_outline,
      'mail_outline': Icons.mail_outline,
      'settings': Icons.settings,
      'notifications': Icons.notifications,
      'logout': Icons.logout,
      'dark_mode': Icons.dark_mode,
      'mail': Icons.mail,
      'verified': Icons.verified,
      'privacy': Icons.privacy_tip,
      'home': Icons.home,
      'info': Icons.info,
      'system_update': Icons.system_update,
      'security': Icons.security,
      'build': Icons.build,
    };

    return icons[iconName] ?? Icons.help;
  }
}
