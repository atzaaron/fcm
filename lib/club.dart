

class Club {
  String name;
  String points;
  String matchesPlayed;
  String victories;
  String draws;
  String defeats;
  String goalFor;
  String goalAgainst;
  String goalDifference;

  Club(String name) {
    this.name = name;
    this.points = "-1";
    this.matchesPlayed = "-1";
    this.victories = "-1";
    this.draws = "-1";
    this.defeats = "-1";
    this.goalFor = "-1";
    this.goalAgainst = "-1";
    this.goalDifference = "-1";
  }
}