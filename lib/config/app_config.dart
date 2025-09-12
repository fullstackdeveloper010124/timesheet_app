class AppConfig {
  // Environment types
  static const String development = 'development';
  static const String production = 'production';

  // Current environment - change this to switch between local and production
  static const String currentEnvironment = development;

  // API Configuration
  static const Map<String, String> apiUrls = {
    development: 'http://localhost:5000/api',
    production: 'https://timesheetsbackend.myadminbuddy.com/api',
  };

  // Get current API URL
  static String get apiUrl => apiUrls[currentEnvironment]!;

  // Environment checks
  static bool get isDevelopment => currentEnvironment == development;
  static bool get isProduction => currentEnvironment == production;

  // Debug settings
  static bool get enableLogging => isDevelopment;
  static bool get enableDebugMode => isDevelopment;

  // App settings
  static const String appName = 'Timely';
  static const String appVersion = '1.0.0';

  // Timeout settings
  static const int apiTimeoutSeconds = 30;
  static const int connectionTimeoutSeconds = 10;

  // Print current configuration (for debugging)
  static void printConfig() {
    if (enableLogging) {
      print('🔧 App Configuration:');
      print('   Environment: $currentEnvironment');
      print('   API URL: $apiUrl');
      print('   Debug Mode: $enableDebugMode');
      print('   Logging: $enableLogging');
    }
  }
}
