import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/primary_button.dart';
import 'hunt_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.15),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scaleXY(end: 1.2, duration: 3.seconds, curve: Curves.easeInOut),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondaryColor.withOpacity(0.1),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scaleXY(end: 1.3, duration: 4.seconds, curve: Curves.easeInOut),
          ),
          
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.map_outlined,
                      size: 100,
                      color: AppTheme.primaryColor,
                    ).animate()
                     .fadeIn(duration: 800.ms)
                     .slideY(begin: -0.2, end: 0, duration: 800.ms, curve: Curves.easeOutBack),
                    const SizedBox(height: 30),
                    
                    Text(
                      'NEON QUEST',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: AppTheme.primaryColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                     .fadeIn(delay: 300.ms, duration: 800.ms)
                     .slideY(begin: 0.2, end: 0, duration: 800.ms, curve: Curves.easeOut),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      'Embark on an immersive treasure hunt. Solve riddles, unlock secrets, and race to the top of the leaderboard.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ).animate()
                     .fadeIn(delay: 600.ms, duration: 800.ms),
                    
                    const SizedBox(height: 50),
                    
                    GlassCard(
                      child: Column(
                        children: [
                          Text(
                            'RULES',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('- Read the clues carefully.\n- Enter the exact answer.\n- Faster answers might earn more points (soon).\n- No cheating!'),
                        ],
                      ),
                    ).animate()
                     .fadeIn(delay: 900.ms, duration: 800.ms)
                     .scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack),
                     
                    const SizedBox(height: 50),
                    
                    PrimaryButton(
                      text: 'START HUNT',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HuntDashboard()),
                        );
                      },
                    ).animate()
                     .fadeIn(delay: 1200.ms, duration: 800.ms),
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
