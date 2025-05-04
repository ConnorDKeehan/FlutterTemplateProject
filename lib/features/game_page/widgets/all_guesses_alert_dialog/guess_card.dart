import 'package:flutter/material.dart';

class GuessCard extends StatelessWidget {
  final int loginId;
  final String guessString;
  final bool amIGameMaster;
  final Function(int) pickWinner;

  const GuessCard({
    super.key, required this.loginId, required this.guessString, required this.amIGameMaster, required this.pickWinner,
  });

  @override
  Widget build(BuildContext context) {
    final colourScheme = Theme.of(context).colorScheme;

    final shadowDarkness = colourScheme.brightness == Brightness.dark ? 0.9 : 0.3;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: colourScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(shadowDarkness),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$loginId - Guess: $guessString',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if(amIGameMaster)
                  TextButton(onPressed: () => pickWinner(loginId), child: Text("Pick Winner"))
              ],
            )
          ],
        ),
      ),
    );
  }
}