# API Configuration Documentation

## Overview

The `ApiConfig` class provides centralized management of all API endpoints used throughout the application. All API calls should reference endpoints defined here.

## Base URL

```
https://api.example.com/v1
```

**Note**: Update this to your actual backend URL.

## Authentication Endpoints

### 1. Login
- **Endpoint**: `/auth/login`
- **Method**: POST
- **URL**: `ApiConfig.getLoginUrl()`
- **Request Body**:
  ```json
  {
    "userId": "user@example.com",
    "password": "password"
  }
  ```
- **Response**:
  ```json
  {
    "token": "jwt_token",
    "user": { "id": "1", "name": "John" }
  }
  ```

### 2. Register
- **Endpoint**: `/auth/register`
- **Method**: POST
- **URL**: `ApiConfig.getRegisterUrl()`
- **Request Body**:
  ```json
  {
    "email": "user@example.com",
    "password": "password",
    "name": "John Doe"
  }
  ```

### 3. Forgot Password
- **Endpoint**: `/auth/forgot-password`
- **Method**: POST
- **URL**: `ApiConfig.getForgotPasswordUrl()`
- **Request Body**:
  ```json
  {
    "email": "user@example.com"
  }
  ```

### 4. Reset Password
- **Endpoint**: `/auth/reset-password`
- **Method**: POST
- **URL**: `ApiConfig.getResetPasswordUrl()`
- **Request Body**:
  ```json
  {
    "token": "reset_token",
    "newPassword": "new_password"
  }
  ```

### 5. Logout
- **Endpoint**: `/auth/logout`
- **Method**: POST
- **URL**: `ApiConfig.getLogoutUrl()`
- **Headers**: Authorization header with bearer token required

### 6. Refresh Token
- **Endpoint**: `/auth/refresh-token`
- **Method**: POST
- **URL**: `ApiConfig.getRefreshTokenUrl()`
- **Request Body**:
  ```json
  {
    "refreshToken": "refresh_token"
  }
  ```

### 7. Verify OTP
- **Endpoint**: `/auth/verify-otp`
- **Method**: POST
- **URL**: `ApiConfig.getVerifyOtpUrl()`
- **Request Body**:
  ```json
  {
    "email": "user@example.com",
    "otp": "123456"
  }
  ```

### 8. Biometric Login
- **Endpoint**: `/auth/biometric-login`
- **Method**: POST
- **URL**: `ApiConfig.getBiometricLoginUrl()`
- **Request Body**:
  ```json
  {
    "biometricData": "encrypted_biometric_data"
  }
  ```

## User Endpoints

### 1. Get User Profile
- **Endpoint**: `/users/profile`
- **Method**: GET
- **URL**: `ApiConfig.getUserProfileUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Response**:
  ```json
  {
    "id": "1",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+1234567890",
    "memberSince": "2024-01-01"
  }
  ```

### 2. Update User Profile
- **Endpoint**: `/users/profile`
- **Method**: PUT
- **URL**: `ApiConfig.getUpdateUserProfileUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**:
  ```json
  {
    "name": "John Doe",
    "phone": "+1234567890"
  }
  ```

### 3. Get User Settings
- **Endpoint**: `/users/settings`
- **Method**: GET
- **URL**: `ApiConfig.getUserSettingsUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Response**:
  ```json
  {
    "darkMode": true,
    "pushNotifications": true,
    "emailNotifications": false,
    "twoFactorEnabled": false
  }
  ```

### 4. Update User Settings
- **Endpoint**: `/users/settings`
- **Method**: PUT
- **URL**: `ApiConfig.getUpdateUserSettingsUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**:
  ```json
  {
    "darkMode": true,
    "pushNotifications": true
  }
  ```

### 5. Change Password
- **Endpoint**: `/users/change-password`
- **Method**: POST
- **URL**: `ApiConfig.getChangePasswordUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**:
  ```json
  {
    "currentPassword": "old_password",
    "newPassword": "new_password"
  }
  ```

## Notification Endpoints

### 1. Get Notifications
- **Endpoint**: `/notifications`
- **Method**: GET
- **URL**: `ApiConfig.getNotificationsUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Query Parameters**: `?page=1&limit=10`
- **Response**:
  ```json
  {
    "notifications": [
      {
        "id": "1",
        "title": "Welcome!",
        "message": "Welcome to our app",
        "timestamp": "2024-01-01T10:00:00Z",
        "read": false
      }
    ],
    "total": 10
  }
  ```

### 2. Mark Notification as Read
- **Endpoint**: `/notifications/{id}/read`
- **Method**: PATCH
- **URL**: `ApiConfig.getMarkNotificationAsReadUrl(notificationId)`
- **Headers**: `Authorization: Bearer {token}`

### 3. Delete Notification
- **Endpoint**: `/notifications/{id}`
- **Method**: DELETE
- **URL**: `ApiConfig.getDeleteNotificationUrl(notificationId)`
- **Headers**: `Authorization: Bearer {token}`

### 4. Update Notification Preferences
- **Endpoint**: `/notifications/preferences`
- **Method**: PUT
- **URL**: `ApiConfig.getUpdateNotificationPreferencesUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**:
  ```json
  {
    "pushNotifications": true,
    "emailNotifications": true,
    "smsNotifications": false
  }
  ```

## Dashboard Endpoints

### 1. Get Dashboard Data
- **Endpoint**: `/dashboard`
- **Method**: GET
- **URL**: `ApiConfig.getDashboardDataUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Response**:
  ```json
  {
    "stats": {
      "totalUsers": 1000,
      "activeUsers": 500,
      "revenue": 50000
    }
  }
  ```

### 2. Get Dashboard Stats
- **Endpoint**: `/dashboard/stats`
- **Method**: GET
- **URL**: `ApiConfig.getDashboardStatsUrl()`
- **Headers**: `Authorization: Bearer {token}`

## Security Endpoints

### 1. Get Two-Factor Settings
- **Endpoint**: `/settings/2fa`
- **Method**: GET
- **URL**: `ApiConfig.getTwoFactorSettingsUrl()`
- **Headers**: `Authorization: Bearer {token}`

### 2. Setup Two-Factor Authentication
- **Endpoint**: `/settings/2fa/setup`
- **Method**: POST
- **URL**: `ApiConfig.getSetupTwoFactorUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Response**:
  ```json
  {
    "qrCode": "data:image/png;base64,...",
    "secret": "JBSWY3DPEBLW64TMMQ"
  }
  ```

### 3. Verify Two-Factor Authentication
- **Endpoint**: `/settings/2fa/verify`
- **Method**: POST
- **URL**: `ApiConfig.getVerifyTwoFactorUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**:
  ```json
  {
    "code": "123456"
  }
  ```

### 4. Disable Two-Factor Authentication
- **Endpoint**: `/settings/2fa/disable`
- **Method**: POST
- **URL**: `ApiConfig.getDisableTwoFactorUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**:
  ```json
  {
    "password": "user_password"
  }
  ```

## Upload Endpoints

### 1. Upload Profile Image
- **Endpoint**: `/users/profile/image`
- **Method**: POST (multipart/form-data)
- **URL**: `ApiConfig.getUploadProfileImageUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**: Form data with image file

### 2. Upload Document
- **Endpoint**: `/documents/upload`
- **Method**: POST (multipart/form-data)
- **URL**: `ApiConfig.getUploadDocumentUrl()`
- **Headers**: `Authorization: Bearer {token}`
- **Request Body**: Form data with document file

## Error Responses

All endpoints follow a standard error response format:

```json
{
  "status": "error",
  "code": 400,
  "message": "Error message",
  "errors": {
    "field": "Specific error for field"
  }
}
```

### Common Status Codes
- `200` - OK
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error

## Authentication Headers

All endpoints requiring authentication should include:

```
Authorization: Bearer {token}
```

Where `{token}` is the JWT token obtained from the login endpoint.

## Usage Examples

### In Dart Code

```dart
import 'package:http/http.dart' as http;
import 'config/api_config.dart';

// Login example
Future<void> login(String userId, String password) async {
  try {
    final response = await http.post(
      Uri.parse(ApiConfig.getLoginUrl()),
      headers: ApiConfig.defaultHeaders,
      body: jsonEncode({
        'userId': userId,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  } catch (e) {
    // Handle exception
  }
}

// Get user profile example
Future<void> getUserProfile(String token) async {
  try {
    final response = await http.get(
      Uri.parse(ApiConfig.getUserProfileUrl()),
      headers: ApiConfig.getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  } catch (e) {
    // Handle exception
  }
}
```

## Constants

### Timeouts
- `connectionTimeout`: 30 seconds
- `receiveTimeout`: 30 seconds

### Default Headers
```json
{
  "Content-Type": "application/json",
  "Accept": "application/json"
}
```

## Notes

- All timestamps are in ISO 8601 format (UTC)
- All IDs are strings
- Replace the base URL with your actual backend URL
- Always include Authorization header for authenticated endpoints
- Handle token refresh automatically in your HTTP client
- Implement proper error handling and user feedback

---

Last Updated: 2024
