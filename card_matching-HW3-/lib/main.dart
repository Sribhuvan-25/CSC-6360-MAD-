// import 'package:flutter/material.dart';
// import 'game_utils.dart';
// import 'info_card.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   TextStyle whiteText = TextStyle(color: Colors.white);
//   Game _game = Game();

//   int points = 0;

//   @override
//   void initState() {
//     super.initState();
//     _game.initGame();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Text(
//               "Card Matching Game",
//               style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 24.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               info_card("Points", "$points"),
//             ],
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.width,
//               width: MediaQuery.of(context).size.width,
//               child: GridView.builder(
//                   itemCount: _game.gameImg!.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 16.0,
//                     mainAxisSpacing: 16.0,
//                   ),
//                   padding: EdgeInsets.all(16.0),
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         if (points >= 400) {
//                           return;
//                         }
//                         print(_game.matchCheck);
//                         setState(() {
//                           _game.gameImg![index] = _game.cards_list[index];
//                           _game.matchCheck
//                               .add({index: _game.cards_list[index]});
//                           print(_game.matchCheck.first);
//                         });
//                         if (_game.matchCheck.length == 2) {
//                           if (_game.matchCheck[0].values.first ==
//                               _game.matchCheck[1].values.first) {
//                             print("true");
//                             points += 100;
//                             _game.matchCheck.clear();
//                           } else {
//                             print("false");

//                             Future.delayed(Duration(milliseconds: 500), () {
//                               print(_game.gameColors);
//                               setState(() {
//                                 _game.gameImg![_game.matchCheck[0].keys.first] =
//                                     _game.hiddenCardpath;
//                                 _game.gameImg![_game.matchCheck[1].keys.first] =
//                                     _game.hiddenCardpath;
//                                 _game.matchCheck.clear();
//                               });
//                             });
//                           }
//                         }
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8.0),
//                           image: DecorationImage(
//                             image: AssetImage(_game.gameImg![index]),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     );
//                   })),
//           points == 400
//               ? Column(
//                   children: [
//                     Text('You Win!!!!!'),
//                     ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _game = Game();
//                             _game.initGame();
//                             points = 0;
//                           });
//                         },
//                         child: Text('Play Again?'))
//                   ],
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'game_utils.dart';
import 'info_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle whiteText = TextStyle(color: Colors.white);
  Game _game = Game();
  int points = 0;
  int secondsPassed = 0;
  Timer? _timer;
  bool isGameStarted = false; // Tracks if the game has started
  bool isGameWon = false; // Tracks if the player has won the game

  @override
  void initState() {
    super.initState();
    _game.initGame();
    _resetTimer(); // Reset timer when game initializes but do not start it
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancel any existing timer
    secondsPassed = 0;
    isGameStarted = false; // Ensure the game has not started yet
    isGameWon = false; // Reset the win condition
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        secondsPassed++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel(); // Stop the timer
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the screen is disposed
    super.dispose();
  }

  void _resetGame() {
    setState(() {
      _game = Game();
      _game.initGame();
      points = 0;
      _resetTimer(); // Reset the timer when the game restarts
    });
  }

  void _checkWinCondition() {
    if (points >= 400) {
      setState(() {
        isGameWon = true; // Mark the game as won
        _stopTimer(); // Stop the timer when the game is won
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Card Matching Game",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              info_card("Points", "$points"),
              info_card("Time", "${secondsPassed}s"),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Prevent tapping after the game is won
                        if (isGameWon) {
                          return;
                        }

                        if (!isGameStarted) {
                          // Start the timer on first tap
                          isGameStarted = true;
                          _startTimer();
                        }

                        if (points >= 400) {
                          return;
                        }

                        setState(() {
                          _game.gameImg![index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                        });

                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            points += 100;
                            _game.matchCheck.clear();
                            _checkWinCondition(); // Check if the player has won
                          } else {
                            points -= 20; // Deduct points for a mismatch
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game.gameImg![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  })),
          isGameWon
              ? Column(
                  children: [
                    Text(
                      'You Win!!!!!',
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                    ElevatedButton(
                        onPressed: _resetGame, child: Text('Play Again?'))
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
