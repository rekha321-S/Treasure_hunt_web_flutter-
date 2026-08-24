class Clue {
  final String id;
  final String text; // The riddle or clue text
  final String answer; // The correct answer
  final String? imageUrl; // Optional image for the clue
  final int points;

  Clue({
    required this.id,
    required this.text,
    required this.answer,
    this.imageUrl,
    this.points = 10,
  });
}
