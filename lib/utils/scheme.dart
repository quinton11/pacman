class MazeScheme {
  List<String> maze = [
    "X XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX X",
    "X              XX               XX               X",
    "X QQQQQQQQQQQQ XXXX XXXXXX XXXX XXXXX XXXXXX XXX X",
    "  QFFFFFFFFFFQ                                   ",
    "X QFQQQQQQQQFQ X UUU XXX UUU III NNNNNNNNNNNNN X X",
    "X QFQ      QFQ X UFU XXX UFU IFI NFFFFFFFFFFFN X X",
    "X QFQQQQQQ QFQ X UFU     UFU IFI NFNNNNNNNNNFN X X",
    "X QFFFFFFQ QFQ X UFUUUUUUUFU IFI NFN       NFN X X",
    "X QQQQQQQQ QFQ X UUUUUUUUUUU III NFN XXXXX NFN X X",
    "X          QFQ X                 NNN       NNN X X",
    "XXX XXXXXX QFQ X XXXXX XXXXX XXX XXX XXXXX XXXXXXX",
    "X        X QQQ                         XXX       X",
    "X XXXXXX X      XXXXXXXXXXXXXXXXXXXXX      XXXXX X",
    "X        XX LLL XXXXXXXXXXXXXXXXXXXXX LLL        X",
    "X XXXXXX XX LFL XXXFFFFFFFFFFFFFFFXXX LFL XXXXXX X",
    "X        XX LFL XXXFFFFFGGGGFFFFFFXXX LFL        X",
    "X XXXXXX XX LLL XXXFFFFFFFFFFFFFFFXXX LLL XXXXXX X",
    "X               XXXXXXXXXXXXXXXXXXXXX            X",
    "XXXXXXXXXXXX XX                       XXXXXXXXXXXX",
    "       XXXXX XXXXXX XXXXXXXXXXX X XXXXXX          ",
    "X TTTT       XXXXXX XXXXXXXXXXX X XXXXXX XXXXXXXXX",
    "X TTFT XXX X XX                 X                X",
    "X TTFTTTTT X XX OOOOOOOOOOOOOOO X X NNNNNNNNNNNN X",
    "X TTFFFFFT X    OFFFFFFFFFFFFFO X X NFFFFFFFFFFN X",
    "X TTFTTTTT X XX OFOOOOOOOOOOOFO X X NFNNNNNNNNFN X",
    "X TTFT     X XX OFOOFFFFFFFOOFO X   NFN      NFN X",
    "X TTFTTTTT X XX OFOOOOOOOOOOOFO X X NFN XXXX NFN X",
    "X TTFFFFFT X XX OFFFFFFFFFFFFFO X X NFN      NFN X",
    "X TTTTTTTT X XX OOOOOOOOOOOOOOO X X NNN XXXX NNN X",
    "X          X XX                 XXX              X",
    "XXXXXXXX XXX XX XX XXXXXXXXXXXXXXXX XXXXXXXXXXXX X",
    "X        XXX XX XX            XXXXX     XXXXXXXX X",
    "X XXXXXX         XX XXX XXXXXXXXXXX XXX          X",
    "X         XXXXXX                       PXXXXXXXX X",
    "X XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX X",
  ];

  List<List<int>> mazeBinary = [];
  int lengthRow = 0;
  int lengthCol = 0;

  void mazeToBinary() {
    String row;
    String point;
    lengthRow = maze.length;
    for (int i = 0; i < maze.length; i++) {
      row = maze[i];
      lengthCol = row.length;
      mazeBinary.insert(i, []);
      for (int j = 0; j < row.length; j++) {
        point = row[j];
        if (point == "X") {
          //barrier
          mazeBinary[i].insert(j, 0);
        } else if (point == "P") {
          mazeBinary[i].insert(j, 2);
        } else if (point == "F") {
          mazeBinary[i].insert(j, 3);
        } else if (point == "Q") {
          mazeBinary[i].insert(j, 4);
        } else if (point == "U") {
          mazeBinary[i].insert(j, 5);
        } else if (point == "I") {
          mazeBinary[i].insert(j, 6);
        } else if (point == "N") {
          mazeBinary[i].insert(j, 7);
        } else if (point == "T") {
          mazeBinary[i].insert(j, 8);
        } else if (point == "O") {
          mazeBinary[i].insert(j, 9);
        } else if (point == "L") {
          mazeBinary[i].insert(j, 10);
        } else if (point == "G") {
          mazeBinary[i].insert(j, 11);
        }else {
          mazeBinary[i].insert(j, 1);
        }
      }
    }
    print("Converted scheme");
    //print(maze);
    //print(mazeBinary);
    /* Calculate the length of each item in a row 
    Use that length to determine the sizing of each wall vector to fit tRhe width and height
    of screen well
    Then after constructing list of positional components, then we render them */
  }
}
