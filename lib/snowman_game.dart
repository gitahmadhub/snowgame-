import 'package:flutter/material.dart';

class SnowmanGame extends StatefulWidget {
  const SnowmanGame({Key? key}) : super(key: key);

  @override
  _SnowmanGameState createState() => _SnowmanGameState();
}

class _SnowmanGameState extends State<SnowmanGame> {
  String secretWord = 'SNOWMAN';
  List<String> guessedLetters = [];
  int attempts = 0;
  int maxAttempts = 7;
  int snowmanIndex = 0; // Track which part of snowman to display
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkGuess(String letter) {
    setState(() {
      if (!guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
        _controller.clear();
        if (!secretWord.contains(letter)) {
          attempts++;
          snowmanIndex++; // Increase snowmanIndex on mistake
        }
      }
    });
  }

  bool isGameWon() {
    return secretWord.split('').every((letter) => guessedLetters.contains(letter));
  }

  bool isGameOver() {
    return attempts >= maxAttempts;
  }

  @override
  Widget build(BuildContext context) {
    int partsToShow = snowmanIndex + 1; // Calculate how many parts of the snowman to show

    return Scaffold(
      appBar: AppBar(
        title: const Text('Snowman Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Guess the Word:',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            Text(
              secretWord.split('').map((letter) {
                return guessedLetters.contains(letter) ? letter : '_';
              }).join(' '),
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 20),
            if (isGameWon())
              Text(
                'Congratulations! You guessed the word!',
                style: TextStyle(color: Colors.green, fontSize: 20),
              )
            else if (isGameOver())
              Text(
                'Game Over! The word was: $secretWord',
                style: TextStyle(color: Colors.red, fontSize: 20),
              )
            else
              Column(
                children: [
                  // Display snowman parts based on attempts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= partsToShow; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/snowman_part$i.jpeg', // Updated image file extension to .jpeg
                            width: 100, // Adjust size as needed
                            height: 100,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          if (value.isNotEmpty && value.length == 1) {
                            checkGuess(value.toUpperCase());
                          }
                        },
                        maxLength: 1,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          hintText: 'Enter a letter',
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Attempts Left: ${maxAttempts - attempts}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
