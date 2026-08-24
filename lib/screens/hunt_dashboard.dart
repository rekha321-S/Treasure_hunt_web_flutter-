import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/hunt_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/primary_button.dart';
import 'clue_screen.dart';

class HuntDashboard extends StatelessWidget {
  const HuntDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MISSION DASHBOARD', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<HuntProvider>(
        builder: (context, provider, child) {
          if (provider.isHuntFinished) {
            return _buildFinishedState(context, provider);
          }
          return _buildActiveState(context, provider);
        },
      ),
    );
  }

  Widget _buildFinishedState(BuildContext context, HuntProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                'HUNT COMPLETED!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Final Score: ${provider.score}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'PLAY AGAIN',
                onPressed: () {
                  provider.restartHunt();
                },
              ),
            ],
          ),
        ).animate().scaleXY(curve: Curves.easeOutBack, duration: 600.ms),
      ),
    );
  }

  Widget _buildActiveState(BuildContext context, HuntProvider provider) {
    return Stack(
      children: [
        // Background radar animation
        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
           .scaleXY(begin: 0, end: 2, duration: 2.seconds)
           .fadeOut(duration: 2.seconds),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SCORE', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('${provider.score}', style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('PROGRESS', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('${provider.currentClueIndex + 1} / ${provider.clues.length}', style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: LinearProgressIndicator(
                  value: provider.progress,
                  backgroundColor: Colors.white10,
                  color: AppTheme.secondaryColor,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ).animate().fadeIn(duration: 500.ms),
              
              const Spacer(),
              
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ClueScreen()),
                  );
                },
                child: GlassCard(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Icon(Icons.lock_open, size: 60, color: AppTheme.primaryColor)
                        .animate(onPlay: (controller) => controller.repeat(reverse: true))
                        .scaleXY(end: 1.1, duration: 1.seconds),
                      const SizedBox(height: 20),
                      Text(
                        'CURRENT CLUE',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 2),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tap to reveal and solve the riddle.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
