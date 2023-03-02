class MazeScheme {
  List<String> maze = [
    "X XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX X",
    "X              XX               XX               X",
    "X XXXXXXXXXXXX XXXX XXXXXX XXXX XXXXX XXXXXX XXX X",
    "  X          X                                    ",
    "X X XXXXXXXX X X XXX XXX XXX XXX XXXXXXXXXXXXX X X",
    "X X X      X X X X X XXX X X X X X           X X X",
    "X X XXXXXX X X X X X     X X X X X XXXXXXXXX X X X",
    "X X      X X X X X XXXXXXX X X X X X       X X X X",
    "X XXXXXXXX X X X XXXXXXXXXXX XXX X X XXXXX X X X X",
    "X          X X X                 XXX       XXX X X",
    "XXX XXXXXX X X X XXXXX XXXXX XXX XXX XXXXX XXXXXXX",
    "X          XXX                         XXX       X",
    "X XXXXXX X      XXXXXXXXXXXXXXXXXXXXX      XXXXX X",
    "X        XX XXX XXXXXXXXXXXXXXXXXXXXX XXX        X",
    "X XXXXXX XX X X XXX               XXX X X XXXXXX X",
    "X        XX X X XXX               XXX X X        X",
    "X XXXXXX XX XXX XXX               XXX XXX XXXXXX X",
    "X               XXXXXXXXXXXXXXXXXXXXX            X",
    "XXXXXXXXXXXX XX                       XXXXXXXXXXXX",
    "       XXXXX XXXXXX XXXXXXXXXXX X XXXXXX          ",
    "X XXXX       XXXXXX XXXXXXXXXXX X XXXXXX XXXXXXXXX",
    "X XX X XXX X XX                 X                X",
    "X XX XXXXX X XX XXXXXXXXXXXXXXX X X XXXXXXXXXXXX X",
    "X XX     X X    X             X X X X          X X",
    "X XX XXXXX X XX X XXXXXXXXXXX X X X X XXXXXXXX X X",
    "X XX X     X XX X XX       XX X X   X X      X X X",
    "X XX XXXXX X XX X XXXXXXXXXXX X X X X X      X X X",
    "X XX     X X XX X             X X X X X      X X X",
    "X XXXXXXXX X XX XXXXXXXXXXXXXXX X X XXX XXXX XXX X",
    "X          X XX                 XXX              X",
    "XXXXXXXX XXX XX XX XXXXXXXXXXXXXXXX XXXXXXXXXXXX X",
    "X        XXX XX XX            XXXXX     XXXXXXXX X",
    "X XXXXXX         XX XX  XXXXXXXXXXX XXX          X",
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
        } else {
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
