import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/route_config.dart';
import 'providers/navigation_provider.dart';
import 'providers/theme_provider.dart';
import 'services/json_loader_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load JSON configuration
  await JsonLoaderService.instance.loadProperties();
  
  // Initialize router
  RouteConfig.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            title: 'JSON Flutter App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            routerConfig: RouteConfig.router,
          );
        },
      ),
    );
  }
}
