import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Basic validation / Mock login
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondaryColor.withOpacity(0.15),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scaleXY(end: 1.2, duration: 4.seconds, curve: Curves.easeInOut),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.1),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scaleXY(end: 1.1, duration: 3.seconds, curve: Curves.easeInOut),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fingerprint,
                      size: 80,
                      color: AppTheme.primaryColor,
                    ).animate()
                     .fadeIn(duration: 800.ms)
                     .scaleXY(begin: 0.8, end: 1.0, curve: Curves.easeOutBack),
                    const SizedBox(height: 20),
                    
                    Text(
                      'NEON QUEST',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: AppTheme.primaryColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 10),
                    
                    const Text(
                      'Authenticate to begin your journey.',
                      style: TextStyle(color: Colors.white70),
                    ).animate().fadeIn(delay: 500.ms),
                    
                    const SizedBox(height: 50),
                    
                    GlassCard(
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'AGENT ID (Email)',
                              labelStyle: const TextStyle(color: Colors.white54),
                              prefixIcon: const Icon(Icons.person_outline, color: AppTheme.primaryColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppTheme.primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'ACCESS CODE (Password)',
                              labelStyle: const TextStyle(color: Colors.white54),
                              prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.secondaryColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppTheme.secondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                     
                    const SizedBox(height: 40),
                    
                    PrimaryButton(
                      text: 'LOGIN',
                      onPressed: _handleLogin,
                    ).animate().fadeIn(delay: 900.ms).scaleXY(begin: 0.9, end: 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
