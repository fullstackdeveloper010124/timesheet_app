import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart scripts/switch_env.dart [local|production]');
    print('Current environments:');
    print('  local      - Use localhost:5000');
    print('  production - Use production server');
    return;
  }

  final environment = args[0].toLowerCase();
  final configFile = File('lib/config/app_config.dart');
  
  if (!configFile.existsSync()) {
    print('❌ Config file not found: ${configFile.path}');
    return;
  }

  String newEnvironment;
  switch (environment) {
    case 'local':
    case 'development':
      newEnvironment = 'development';
      break;
    case 'production':
    case 'prod':
      newEnvironment = 'production';
      break;
    default:
      print('❌ Invalid environment: $environment');
      print('Valid options: local, development, production, prod');
      return;
  }

  try {
    String content = configFile.readAsStringSync();
    
    // Replace the current environment
    final regex = RegExp(r"static const String currentEnvironment = '[^']+';");
    final newLine = "static const String currentEnvironment = '$newEnvironment';";
    
    if (regex.hasMatch(content)) {
      content = content.replaceFirst(regex, newLine);
      configFile.writeAsStringSync(content);
      
      print('✅ Environment switched to: $newEnvironment');
      print('📱 Restart your Flutter app to apply changes');
      
      // Show current API URL
      final apiUrlRegex = RegExp(r"'$newEnvironment': '([^']+)'");
      final match = apiUrlRegex.firstMatch(content);
      if (match != null) {
        print('🌐 API URL: ${match.group(1)}');
      }
    } else {
      print('❌ Could not find environment configuration in config file');
    }
  } catch (e) {
    print('❌ Error updating config: $e');
  }
}
