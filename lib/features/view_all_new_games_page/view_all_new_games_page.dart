import 'package:flutter/material.dart';
import 'package:songguessgame/apis/songguessgame_api.dart';
import 'package:songguessgame/features/view_all_new_games_page/widgets/add_game_button.dart';
import 'package:songguessgame/features/view_all_new_games_page/widgets/game_card.dart';
import 'package:songguessgame/main.dart';
import 'package:songguessgame/models/entities/game.dart';

class ViewAllNewGamesPage extends StatefulWidget {
  const ViewAllNewGamesPage({super.key});

  @override
  State<ViewAllNewGamesPage> createState() => _ViewAllNewGamesPageState();
}

class _ViewAllNewGamesPageState extends State<ViewAllNewGamesPage> {
  List<Game> newGames = [];
  bool isLoading = true;

  @override
  void initState() {
    getAndSetAllNewGames();
    signalR.registerHandler('NewGuess', handleNewGameNotification);
    super.initState();
  }

  void handleNewGameNotification(List<Object?>? args){
    getAndSetAllNewGames();
  }

  void getAndSetAllNewGames() async {
    setState(() {
      isLoading = true;
    });

    newGames = await getAllNewGames();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: newGames.length,
        itemBuilder: (context, index) {
          final game = newGames[index];
          return GameCard(game: game);
        },
      ),
      floatingActionButton: AddGameButton(onAdded: getAndSetAllNewGames),
    );
  }
}
