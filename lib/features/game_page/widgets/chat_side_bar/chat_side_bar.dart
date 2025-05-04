import 'package:flutter/material.dart';
import 'package:songguessgame/models/notifications/new_guess_notification.dart';

class ChatSideBar extends StatelessWidget {
  final List<NewGuessNotification> guesses;
  final TextEditingController guessController;
  final bool guessingEnabled;
  final VoidCallback onGuess;
  const ChatSideBar({super.key, required this.guesses, required this.onGuess, required this.guessController, required this.guessingEnabled});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                itemCount: guesses.length,
                itemBuilder: (context, index) {
                  var item = guesses[index];
                  return Text("Player: ${item.loginId} guessed");
                }
            )
        ),
        Row(children: [
          Expanded(child:
          TextFormField(
            decoration: const InputDecoration(labelText: "Guess Current Song"),
            enabled: true,
            controller: guessController,
          )),
          TextButton(onPressed: onGuess, child: Text("Guess"))
        ])
        ])
    );
  }
}