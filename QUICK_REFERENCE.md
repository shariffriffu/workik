# Quick Reference Guide

## 🚀 Getting Started

### Run the App
```bash
flutter run
```

### Clean Build
```bash
flutter clean
flutter pub get
flutter run
```

### Build Release APK
```bash
flutter build apk --release
```

## 📖 Navigation

### Navigate to a Page
```dart
context.go('/login');
context.go('/dashboard');
context.go('/profile');
context.go('/settings');
context.go('/notifications');
context.go('/forgot-password');
```

### With Parameters
```dart
context.go('/profile?id=123');
```

## 🎨 Common Tasks

### Change Theme
```dart
context.read<ThemeProvider>().toggleTheme();
context.read<ThemeProvider>().setThemeMode(ThemeMode.dark);
```

### Show Snackbar
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Message')),
);
```

### Show Dialog
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Title'),
    content: Text('Content'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
    ],
  ),
);
```

## 📝 Working with JSON

### Load Properties
```dart
final pageData = JsonLoaderService.instance.getPage('pageName');
final children = pageData['children'] as List<dynamic>? ?? [];
```

### Get Validation Rules
```dart
final validation = JsonLoaderService.instance.getValidation('login');
```

### Get Styles
```dart
final textStyle = JsonLoaderService.instance.getTextStyle('heading1');
final buttonStyle = JsonLoaderService.instance.getButtonStyle('typeLogin');
final color = JsonLoaderService.instance.getColor('primary');
```

## 🎯 Adding a New Page

### 1. Add to properties.json
```json
{
  "pages": {
    "newPage": {
      "type": "ScaffoldPage",
      "appBarTitle": "New Page",
      "children": [...]
    }
  }
}
```

### 2. Create Page Class
```dart
// lib/pages/new_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/json_loader_service.dart';
import '../utils/json_widget_builder.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    final pageData = JsonLoaderService.instance.getPage('newPage');
    final children = pageData['children'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(pageData['appBarTitle'] ?? 'Page'),
        backgroundColor: const Color(0xFF4ECDC4),
      ),
      body: Column(
        children: children.map((child) {
          return JsonWidgetBuilder.buildWidget(
            context,
            child as Map<String, dynamic>,
            () => _handleNavigation(child['action']),
          );
        }).toList(),
      ),
    );
  }

  void _handleNavigation(String? action) {
    // Handle actions
  }
}
```

### 3. Add Route
```dart
// In route_config.dart
GoRoute(
  path: '/new-page',
  name: 'new_page',
  builder: (context, state) => const NewPage(),
)
```

## 🛠️ Adding a Custom Widget

### 1. Create Widget
```dart
// lib/widgets/custom_widget.dart
class CustomWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title),
    );
  }
}
```

### 2. Add to JsonWidgetBuilder
```dart
// In json_widget_builder.dart
case 'CustomWidget':
  return _buildCustomWidget(properties);

// ...

static Widget _buildCustomWidget(Map<String, dynamic>? props) {
  return CustomWidget(
    title: props?['title'] ?? '',
  );
}
```

### 3. Use in JSON
```json
{
  "type": "CustomWidget",
  "title": "My Widget"
}
```

## 🎨 Colors

### Update Colors
Edit `colors` in properties.json:
```json
{
  "styles": {
    "colors": {
      "primary": "#4ECDC4",
      "secondary": "#FF6B6B",
      "background": "#1A1A2E"
    }
  }
}
```

### Use Color
```dart
ColorUtils.fromHex('#4ECDC4');
ColorUtils.fromHex('#FF6B6B');
```

## 📱 Screen Sizes

### Get Screen Dimensions
```dart
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
```

### Responsive Layout
```dart
SizedBox(
  width: MediaQuery.of(context).size.width * 0.9,
  child: // content
)
```

## 🔌 API Calls

### Using ApiConfig
```dart
import 'config/api_config.dart';

// Get URL
final url = ApiConfig.getLoginUrl();
final headers = ApiConfig.getAuthHeaders(token);

// Make request
final response = await http.post(
  Uri.parse(url),
  headers: headers,
  body: jsonEncode(data),
);
```

### Common Endpoints
```
Login: ApiConfig.getLoginUrl()
Profile: ApiConfig.getUserProfileUrl()
Settings: ApiConfig.getUserSettingsUrl()
Notifications: ApiConfig.getNotificationsUrl()
```

## 🗂️ File Organization

### Where to Put What
- **Pages**: `lib/pages/`
- **Widgets**: `lib/widgets/`
- **Models**: `lib/models/`
- **Services**: `lib/services/`
- **Providers**: `lib/providers/`
- **Utils**: `lib/utils/`
- **Themes**: `lib/theme/`
- **Config**: `lib/config/`

## 🐛 Debugging

### Print Logs
```dart
print('Debug message');
debugPrint('Info message');
```

### Check Widget Tree
```dart
// Add this to MaterialApp
debugShowCheckedModeBanner: false,
```

### Hot Reload
```bash
Press 'r' in terminal during flutter run
```

### Hot Restart
```bash
Press 'R' in terminal during flutter run
```

## 📊 JSON Structure Reference

### Page Definition
```json
{
  "pages": {
    "pageName": {
      "type": "ScaffoldPage|GlassPage",
      "appBarTitle": "Title",
      "showBackButton": true,
      "bottomNavigationBar": false,
      "children": [],
      "validation": {}
    }
  }
}
```

### Widget Definition
```json
{
  "type": "WidgetName",
  "id": "unique_id",
  "property1": "value1",
  "property2": 123,
  "nested": {
    "type": "NestedWidget"
  },
  "children": []
}
```

### Styles Definition
```json
{
  "styles": {
    "textStyles": {
      "styleName": {
        "fontSize": 14,
        "fontWeight": "bold",
        "color": "#FFFFFF"
      }
    },
    "buttonStyles": {},
    "textFieldStyles": {},
    "colors": {}
  }
}
```

## 🔐 Validation

### Add Validation Rule
```json
{
  "validation": {
    "email": {
      "regex": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
      "errorMessage": "Invalid email"
    }
  }
}
```

### Common Regex Patterns
```
Email: ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
Phone: ^[0-9]{10}$
Password (min 8): ^.{8,}$
URL: ^https?://.*$
Alphanumeric: ^[a-zA-Z0-9]+$
Not empty: .+
```

## 📦 Dependencies

### Add Package
```bash
flutter pub add package_name
```

### Update Dependencies
```bash
flutter pub upgrade
```

### Install Specific Version
```bash
flutter pub add package_name:^1.0.0
```

## 🎯 State Management

### Access Provider
```dart
// Read value
final theme = context.read<ThemeProvider>().themeMode;

// Watch for changes
final theme = context.watch<ThemeProvider>().themeMode;

// Consumer widget
Consumer<ThemeProvider>(
  builder: (context, provider, child) {
    return Text(provider.themeMode.toString());
  },
)
```

## 📝 Common Patterns

### Form Handling
```dart
final Map<String, TextEditingController> _controllers = {};

@override
void initState() {
  super.initState();
  _controllers['email'] = TextEditingController();
}

@override
void dispose() {
  for (var controller in _controllers.values) {
    controller.dispose();
  }
  super.dispose();
}
```

### Validation
```dart
void _validate() {
  final email = _controllers['email']?.text ?? '';
  if (email.isEmpty) {
    // Show error
  }
}
```

### Navigation
```dart
void _handleNavigation(String? action) {
  if (action == null) return;
  
  switch (action) {
    case 'goto_login':
      context.go('/login');
      break;
    case 'goto_dashboard':
      context.go('/dashboard');
      break;
  }
}
```

## 💾 Local Storage

### Save Data
```dart
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
await prefs.setString('key', 'value');
```

### Retrieve Data
```dart
final prefs = await SharedPreferences.getInstance();
final value = prefs.getString('key');
```

## 🔍 Troubleshooting

### App Crashes
1. Check console output
2. Review error messages
3. Check hot reload errors
4. Try hot restart

### JSON Not Loading
1. Check file path in pubspec.yaml
2. Verify JSON syntax
3. Check JsonLoaderService initialization
4. Look for file encoding issues

### Widget Not Rendering
1. Verify widget type in JSON
2. Check build method in JsonWidgetBuilder
3. Ensure widget is imported
4. Check for null values

### Navigation Not Working
1. Verify route path
2. Check route name spelling
3. Ensure page class exists
4. Check route initialization

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Go Router Docs](https://pub.dev/packages/go_router)
- [Provider Docs](https://pub.dev/packages/provider)

---

**Quick Tips**
- Use `ctrl + .` (VSCode) to auto-import
- Use `shift + ctrl + r` to refactor
- Press `alt + enter` for quick fixes
- Check `.gitignore` before committing
