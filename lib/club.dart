

class Club {
  String name;
  int points;
  int matchesPlayed;
  int victories;
  int draws;
  int defeats;
  int goalFor;
  int goalAgainst;
  int goalDifference;


  Club(String name, int points, int matchesPlayed, int victories, int draws, int defeats, int goalFor, int goalAgainst, int goalDifference) {
    this.name = name;
    this.points = points;
    this.matchesPlayed = matchesPlayed;
    this.victories = victories;
    this.draws = draws;
    this.defeats = defeats;
    this.goalFor = goalFor;
    this.goalAgainst = goalAgainst;
    this.goalDifference = goalDifference;
  }
}