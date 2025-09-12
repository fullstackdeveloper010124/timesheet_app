# Environment Configuration Guide

This Flutter app supports both local development and production environments. You can easily switch between them.

## 🌐 Available Environments

### 1. **Development (Local)**
- **API URL**: `http://localhost:5000/api`
- **Use case**: Local development and testing
- **Features**: Debug logging enabled, detailed error messages

### 2. **Production (Live)**
- **API URL**: `https://timesheetsbackend.myadminbuddy.com/api`
- **Use case**: Production deployment
- **Features**: Optimized performance, minimal logging

## 🔧 How to Switch Environments

### Method 1: Edit Configuration File (Recommended)
1. Open `lib/config/app_config.dart`
2. Change the `currentEnvironment` value:
   ```dart
   // For local development
   static const String currentEnvironment = development;
   
   // For production
   static const String currentEnvironment = production;
   ```
3. Save the file and restart your Flutter app

### Method 2: Use the Switch Script
```bash
# Switch to local development
dart scripts/switch_env.dart local

# Switch to production
dart scripts/switch_env.dart production
```

## 🚀 Running Your Local Backend

To use the local environment, make sure your backend server is running:

1. Navigate to your backend directory:
   ```bash
   cd Timesheet_Backend
   ```

2. Start the server:
   ```bash
   npm start
   # or
   node server.js
   ```

3. The server should be running on `http://localhost:5000`

## 📱 Testing Both Environments

### Local Testing
1. Set environment to `development` in `app_config.dart`
2. Start your local backend server
3. Run Flutter app: `flutter run`
4. Check console for debug logs (🌐, 📤, ❌ emojis)

### Production Testing
1. Set environment to `production` in `app_config.dart`
2. Run Flutter app: `flutter run`
3. App will connect to live production server

## 🔍 Debug Features

When using development environment:
- **API Logging**: All HTTP requests are logged to console
- **Request Data**: POST request data is displayed
- **Error Details**: Detailed error messages
- **Configuration Info**: App config is printed on startup

## 📋 Environment Checklist

### Before Switching to Local:
- [ ] Backend server is running on localhost:5000
- [ ] Database is accessible locally
- [ ] CORS is configured for localhost
- [ ] Environment is set to `development`

### Before Switching to Production:
- [ ] Production server is accessible
- [ ] SSL certificate is valid
- [ ] Environment is set to `production`
- [ ] Test with production data

## 🛠️ Troubleshooting

### Common Issues:

1. **Connection Refused (Local)**
   - Check if backend server is running
   - Verify port 5000 is not blocked
   - Check firewall settings

2. **CORS Errors (Local)**
   - Ensure backend CORS is configured for localhost
   - Check if backend allows your Flutter app's origin

3. **SSL Errors (Production)**
   - Verify SSL certificate is valid
   - Check if production server is accessible

4. **API Not Found**
   - Verify the API endpoints exist on the target server
   - Check if the base URL is correct

## 📊 Current Configuration

To see your current configuration, the app will print it to console when in development mode:

```
🔧 App Configuration:
   Environment: development
   API URL: http://localhost:5000/api
   Debug Mode: true
   Logging: true
```

## 🔄 Quick Switch Commands

```bash
# Switch to local and restart
dart scripts/switch_env.dart local && flutter run

# Switch to production and restart  
dart scripts/switch_env.dart production && flutter run
```

## 📝 Notes

- Always restart your Flutter app after changing environment
- Local development requires your backend server to be running
- Production environment uses the live server (no local setup needed)
- Debug logging is automatically disabled in production for performance
