/// API Configuration - All API endpoints and configurations are defined here
class ApiConfig {
  // Base URL
  static const String baseUrl = 'https://api.example.com/v1';
  
  // Auth Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh-token';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String biometricLoginEndpoint = '/auth/biometric-login';
  
  // User Endpoints
  static const String getUserProfileEndpoint = '/users/profile';
  static const String updateUserProfileEndpoint = '/users/profile';
  static const String getUserSettingsEndpoint = '/users/settings';
  static const String updateUserSettingsEndpoint = '/users/settings';
  static const String changePasswordEndpoint = '/users/change-password';
  
  // Notification Endpoints
  static const String getNotificationsEndpoint = '/notifications';
  static const String markNotificationAsReadEndpoint = '/notifications/{id}/read';
  static const String deleteNotificationEndpoint = '/notifications/{id}';
  static const String updateNotificationPreferencesEndpoint = '/notifications/preferences';
  
  // Dashboard Endpoints
  static const String getDashboardDataEndpoint = '/dashboard';
  static const String getDashboardStatsEndpoint = '/dashboard/stats';
  
  // Settings Endpoints
  static const String getTwoFactorSettingsEndpoint = '/settings/2fa';
  static const String setupTwoFactorEndpoint = '/settings/2fa/setup';
  static const String verifyTwoFactorEndpoint = '/settings/2fa/verify';
  static const String disableTwoFactorEndpoint = '/settings/2fa/disable';
  
  // Upload Endpoints
  static const String uploadProfileImageEndpoint = '/users/profile/image';
  static const String uploadDocumentEndpoint = '/documents/upload';
  
  // Static Methods for building full URLs
  
  /// Get full URL for login
  static String getLoginUrl() => '$baseUrl$loginEndpoint';
  
  /// Get full URL for register
  static String getRegisterUrl() => '$baseUrl$registerEndpoint';
  
  /// Get full URL for forgot password
  static String getForgotPasswordUrl() => '$baseUrl$forgotPasswordEndpoint';
  
  /// Get full URL for reset password
  static String getResetPasswordUrl() => '$baseUrl$resetPasswordEndpoint';
  
  /// Get full URL for logout
  static String getLogoutUrl() => '$baseUrl$logoutEndpoint';
  
  /// Get full URL for refresh token
  static String getRefreshTokenUrl() => '$baseUrl$refreshTokenEndpoint';
  
  /// Get full URL for verify OTP
  static String getVerifyOtpUrl() => '$baseUrl$verifyOtpEndpoint';
  
  /// Get full URL for biometric login
  static String getBiometricLoginUrl() => '$baseUrl$biometricLoginEndpoint';
  
  /// Get full URL for user profile
  static String getUserProfileUrl() => '$baseUrl$getUserProfileEndpoint';
  
  /// Get full URL for update user profile
  static String getUpdateUserProfileUrl() => '$baseUrl$updateUserProfileEndpoint';
  
  /// Get full URL for user settings
  static String getUserSettingsUrl() => '$baseUrl$getUserSettingsEndpoint';
  
  /// Get full URL for update user settings
  static String getUpdateUserSettingsUrl() => '$baseUrl$updateUserSettingsEndpoint';
  
  /// Get full URL for change password
  static String getChangePasswordUrl() => '$baseUrl$changePasswordEndpoint';
  
  /// Get full URL for notifications
  static String getNotificationsUrl() => '$baseUrl$getNotificationsEndpoint';
  
  /// Get full URL for mark notification as read
  static String getMarkNotificationAsReadUrl(String notificationId) =>
      '$baseUrl${markNotificationAsReadEndpoint.replaceAll('{id}', notificationId)}';
  
  /// Get full URL for delete notification
  static String getDeleteNotificationUrl(String notificationId) =>
      '$baseUrl${deleteNotificationEndpoint.replaceAll('{id}', notificationId)}';
  
  /// Get full URL for update notification preferences
  static String getUpdateNotificationPreferencesUrl() =>
      '$baseUrl$updateNotificationPreferencesEndpoint';
  
  /// Get full URL for dashboard data
  static String getDashboardDataUrl() => '$baseUrl$getDashboardDataEndpoint';
  
  /// Get full URL for dashboard stats
  static String getDashboardStatsUrl() => '$baseUrl$getDashboardStatsEndpoint';
  
  /// Get full URL for 2FA settings
  static String getTwoFactorSettingsUrl() => '$baseUrl$getTwoFactorSettingsEndpoint';
  
  /// Get full URL for setup 2FA
  static String getSetupTwoFactorUrl() => '$baseUrl$setupTwoFactorEndpoint';
  
  /// Get full URL for verify 2FA
  static String getVerifyTwoFactorUrl() => '$baseUrl$verifyTwoFactorEndpoint';
  
  /// Get full URL for disable 2FA
  static String getDisableTwoFactorUrl() => '$baseUrl$disableTwoFactorEndpoint';
  
  /// Get full URL for profile image upload
  static String getUploadProfileImageUrl() => '$baseUrl$uploadProfileImageEndpoint';
  
  /// Get full URL for document upload
  static String getUploadDocumentUrl() => '$baseUrl$uploadDocumentEndpoint';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  /// Get headers with authentication token
  static Map<String, String> getAuthHeaders(String token) {
    return {
      ...defaultHeaders,
      'Authorization': 'Bearer $token',
    };
  }
}
