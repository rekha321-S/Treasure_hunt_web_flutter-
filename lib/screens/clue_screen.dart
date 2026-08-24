import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../providers/hunt_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/primary_button.dart';

class ClueScreen extends StatefulWidget {
  const ClueScreen({Key? key}) : super(key: key);

  @override
  State<ClueScreen> createState() => _ClueScreenState();
}

class _ClueScreenState extends State<ClueScreen> {
  final TextEditingController _answerController = TextEditingController();
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  bool _showError = false;

  @override
  void dispose() {
    _answerController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _submit(HuntProvider provider) {
    if (provider.submitAnswer(_answerController.text)) {
      setState(() => _showError = false);
      _confettiController.play();
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    } else {
      setState(() => _showError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HuntProvider>(context, listen: false);
    final clue = provider.currentClue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'CLUE #${provider.currentClueIndex + 1}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ).animate().fadeIn().slideY(begin: -0.2, end: 0, curve: Curves.easeOut),
                  
                  const SizedBox(height: 40),
                  
                  GlassCard(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      clue.text,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ).animate().scaleXY(begin: 0.9, end: 1, duration: 500.ms, curve: Curves.easeOutBack),
                  
                  const SizedBox(height: 40),
                  
                  TextField(
                    controller: _answerController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Enter your answer...',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                      ),
                      errorText: _showError ? 'Incorrect answer. Try again.' : null,
                    ),
                    onSubmitted: (_) => _submit(provider),
                  ).animate().fadeIn(delay: 300.ms),
                  
                  const SizedBox(height: 40),
                  
                  PrimaryButton(
                    text: 'SUBMIT ANSWER',
                    onPressed: () => _submit(provider),
                  ).animate().fadeIn(delay: 500.ms),
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [AppTheme.primaryColor, AppTheme.secondaryColor, Colors.white],
          ),
        ],
      ),
    );
  }
}
