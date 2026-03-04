# JSON Flutter App - Dynamic UI Rendering

A comprehensive Flutter application that demonstrates JSON-driven UI rendering. The entire UI is controlled by JSON configuration files, making it highly modular and easy to customize.

## 📋 Project Overview

This project showcases:
- **JSON-Driven UI**: All UI components are defined in `properties.json`
- **5 Complete Pages**: Login, Forgot Password, Dashboard, Profile, Settings, and Notifications
- **Dynamic Widget Building**: Automatic rendering of widgets from JSON configuration
- **Form Validation**: JSON-based validation rules
- **API Configuration**: Centralized API endpoint management
- **State Management**: Using Provider for theme and navigation
- **Modern UI**: Glass morphism effect and gradient backgrounds

## 📁 Project Structure

```
lib/
├── config/
│   ├── api_config.dart          # All API endpoints
│   └── route_config.dart        # Navigation routes
├── models/
├── pages/
│   ├── login_page.dart
│   ├── forgot_password_page.dart
│   ├── dashboard_page.dart
│   ├── profile_page.dart
│   ├── settings_page.dart
│   └── notifications_page.dart
├── providers/
│   ├── theme_provider.dart
│   └── navigation_provider.dart
├── services/
│   └── json_loader_service.dart
├── theme/
│   └── app_theme.dart
├── utils/
│   ├── json_widget_builder.dart  # Core JSON to Widget renderer
│   └── color_utils.dart
├── widgets/
│   ├── custom_text_field.dart
│   ├── custom_button.dart
│   ├── dashboard_card.dart
│   ├── gesture_detector_text.dart
│   ├── profile_detail_field.dart
│   ├── settings_section_header.dart
│   ├── settings_toggle_item.dart
│   ├── settings_option_item.dart
│   └── notification_item.dart
└── main.dart

assets/
└── json/
    └── properties.json          # Main configuration file
```

## 🎯 Pages

### 1. **Login Page** (`login`)
- User ID/Email input
- Password input with visibility toggle
- Form validation
- Biometric authentication placeholder
- Navigation to forgot password

### 2. **Forgot Password Page** (`forgotPassword`)
- Email input
- Email validation (regex-based)
- Password reset link sending
- Back to login navigation

### 3. **Dashboard Page** (`dashboard`)
- Welcome card
- Grid of action cards (Profile, Settings, Notifications, Logout)
- Bottom navigation bar
- Quick access to all major sections

### 4. **Profile Page** (`profile`)
- User avatar with circular display
- Profile information display
- Contact details
- Membership information
- Edit profile button

### 5. **Settings Page** (`settings`)
- **Display Settings**: Dark mode toggle
- **Notification Settings**: Push and email notification toggles
- **Security Settings**: Password change, 2FA setup
- **About Section**: App version, privacy policy

### 6. **Notifications Page** (`notifications`)
- Multiple notification items
- Color-coded notification types
- Timestamp display
- Notification icons

## 🔧 API Configuration

The `ApiConfig` class manages all API endpoints:

```dart
// Auth Endpoints
- POST /auth/login
- POST /auth/register
- POST /auth/forgot-password
- POST /auth/reset-password
- POST /auth/logout
- POST /auth/refresh-token
- POST /auth/verify-otp
- POST /auth/biometric-login

// User Endpoints
- GET /users/profile
- PUT /users/profile
- GET /users/settings
- PUT /users/settings
- POST /users/change-password

// Notification Endpoints
- GET /notifications
- PATCH /notifications/{id}/read
- DELETE /notifications/{id}
- PUT /notifications/preferences

// Dashboard Endpoints
- GET /dashboard
- GET /dashboard/stats

// Settings Endpoints
- GET /settings/2fa
- POST /settings/2fa/setup
- POST /settings/2fa/verify
- POST /settings/2fa/disable

// Upload Endpoints
- POST /users/profile/image
- POST /documents/upload
```

## 📝 JSON Configuration Format

### Page Structure
```json
{
  "pages": {
    "pageName": {
      "type": "ScaffoldPage|GlassPage",
      "appBarTitle": "Title",
      "showBackButton": true,
      "children": [
        {
          "type": "WidgetType",
          "property1": "value1",
          "property2": "value2"
        }
      ],
      "validation": {
        "fieldId": {
          "regex": "pattern",
          "errorMessage": "Error message"
        }
      }
    }
  }
}
```

### Supported Widget Types
- `SizedBox` - Spacing widget
- `TextField` - Text input field
- `Button` - Action button
- `Text` - Text display
- `Center` - Center alignment
- `Container` - Box container
- `Column` - Vertical layout
- `Row` - Horizontal layout
- `Card` - Card component
- `GestureDetectorText` - Clickable text
- `GestureDetectorIcon` - Clickable icon
- `CircleAvatar` - Circular avatar
- `Icon` - Icon display
- `DashboardCard` - Dashboard action card
- `GridView` - Grid layout
- `SingleChildScrollView` - Scrollable view
- `ProfileDetailField` - Profile info field
- `SettingsSectionHeader` - Settings section title
- `SettingsToggleItem` - Toggle setting
- `SettingsOptionItem` - Option setting
- `NotificationItem` - Notification display

## 🎨 Styling System

Styles are defined in `properties.json`:

```json
{
  "styles": {
    "textStyles": {
      "heading1": { "fontSize": 32, "fontWeight": "bold", "color": "#FFFFFF" },
      "body": { "fontSize": 14, "fontWeight": "normal", "color": "#FFFFFF" }
    },
    "buttonStyles": {
      "typeLogin": { "backgroundColor": "#4ECDC4", "foregroundColor": "#FFFFFF" }
    },
    "textFieldStyles": {
      "typeGlass": { "backgroundColor": "rgba(255, 255, 255, 0.1)" }
    },
    "colors": {
      "primary": "#4ECDC4",
      "secondary": "#FF6B6B"
    }
  }
}
```

## 🔐 Validation

Form validation is JSON-based using regex patterns:

```json
{
  "validation": {
    "userId": {
      "regex": ".+",
      "errorMessage": "* Please enter User ID"
    },
    "email": {
      "regex": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
      "errorMessage": "* Please enter valid email"
    }
  }
}
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd json_flutter_app
```

2. Get dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📱 Features

✅ **JSON-Driven Architecture** - Entire UI controlled by JSON
✅ **5 Complete Pages** - Login, Forgot Password, Dashboard, Profile, Settings, Notifications
✅ **Dynamic Form Validation** - Regex-based validation from JSON
✅ **Theme Support** - Light/Dark mode with provider
✅ **Navigation** - Go Router for type-safe navigation
✅ **State Management** - Provider for global state
✅ **API Configuration** - Centralized API management
✅ **Modern UI** - Glass morphism, gradients, and smooth animations
✅ **Icon Support** - Material Icons integration
✅ **Responsive Design** - Adapts to different screen sizes

## 🛠️ Customization

### Adding a New Page

1. Add page definition to `properties.json`:
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

2. Create a new page file in `lib/pages/new_page.dart`

3. Add route to `route_config.dart`:
```dart
GoRoute(
  path: '/new-page',
  name: 'new_page',
  builder: (context, state) => const NewPage(),
)
```

### Modifying Styles

Edit the `styles` section in `properties.json` to change colors, fonts, and sizing.

### Adding New Widget Types

1. Add widget support in `json_widget_builder.dart`
2. Create the widget class if needed
3. Add the build method

## 📊 Navigation Flow

```
Login Page
├── Forgot Password Page
└── Dashboard Page
    ├── Profile Page
    ├── Settings Page
    └── Notifications Page
```

## 🔗 Dependencies

- `flutter` - Core framework
- `provider` - State management
- `go_router` - Navigation
- `google_fonts` - Typography
- `http` - HTTP client
- `shared_preferences` - Local storage
- `glassmorphism` - Glass effect widgets

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For issues and questions, please create an issue in the repository.

---

**Happy Coding!** 🚀
