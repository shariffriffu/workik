import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoaderService {
  static final JsonLoaderService _instance = JsonLoaderService._internal();
  
  late Map<String, dynamic> _propertiesJson;

  JsonLoaderService._internal();

  static JsonLoaderService get instance => _instance;

  Future<void> loadProperties() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/properties.json');
      _propertiesJson = jsonDecode(jsonString);
    } catch (e) {
      throw Exception('Error loading properties.json: $e');
    }
  }

  Map<String, dynamic> get propertiesJson => _propertiesJson;

  Map<String, dynamic> getPage(String pageName) {
    return _propertiesJson['pages']?[pageName] ?? {};
  }

  List<dynamic> getPageChildren(String pageName) {
    return getPage(pageName)['children'] ?? [];
  }

  Map<String, dynamic> getValidation(String pageName) {
    return getPage(pageName)['validation'] ?? {};
  }

  Map<String, dynamic> getStyles() {
    return _propertiesJson['styles'] ?? {};
  }

  Map<String, dynamic> getTextStyle(String styleName) {
    final styles = getStyles();
    return styles['textStyles']?[styleName] ?? {};
  }

  Map<String, dynamic> getButtonStyle(String styleName) {
    final styles = getStyles();
    return styles['buttonStyles']?[styleName] ?? {};
  }

  Map<String, dynamic> getTextFieldStyle(String styleName) {
    final styles = getStyles();
    return styles['textFieldStyles']?[styleName] ?? {};
  }

  Map<String, dynamic> getColors() {
    final styles = getStyles();
    return styles['colors'] ?? {};
  }

  String? getColor(String colorName) {
    return getColors()[colorName];
  }
}
