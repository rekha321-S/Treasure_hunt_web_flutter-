import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/hunt_provider.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HuntProvider()),
      ],
      child: const NeonQuestApp(),
    ),
  );
}

class NeonQuestApp extends StatelessWidget {
  const NeonQuestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
