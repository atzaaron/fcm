import 'package:fcm_results/club.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Standings extends StatefulWidget {

  final String championship;
  Standings({Key key, @required this.championship}) : super(key: key);

  @override
  _Standings createState() => _Standings();
}


class _Standings extends State<Standings> {

  List<Club> clubs = [];
  String urlChampionship = "";

  Future fetchClub() async {
    final webScraper = WebScraper('https://districtfootgers.fff.fr');

    print(widget.championship);
    if (await webScraper.loadWebPage(widget.championship)) {
      List<Map<String, dynamic>> nameAndPoints = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-bold', []);
      List<Map<String, dynamic>> details = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-content', []);
      Club tmpClub;
      int indexClub = 0;

      this.urlChampionship = widget.championship;
      nameAndPoints.asMap().forEach((index, value) {
        //find name & points of the team
        if (index % 2 == 0) {
          tmpClub = new Club(value['title']);
        } else {
          tmpClub.points = value['title'];
          this.clubs.add(tmpClub);
        }
      });

      details.asMap().forEach((index, value) { 
        //find the details of each club
        String indexString = index.toString();

        if (index % 10 == 0 && index != 0) {
          indexClub += 1;
        }
        if (indexString[indexString.length - 1] == '1') {
          this.clubs[indexClub].matchesPlayed = value['title'];
        } else if (indexString[indexString.length - 1] == '2') {
          this.clubs[indexClub].victories = value['title'];
        } else if (indexString[indexString.length - 1] == '3') {
          this.clubs[indexClub].draws = value['title'];
        } else if (indexString[indexString.length - 1] == '4') {
          this.clubs[indexClub].defeats = value['title'];
        } else if (indexString[indexString.length - 1] == '6') {
          this.clubs[indexClub].goalFor = value['title'];
        } else if (indexString[indexString.length - 1] == '7') {
          this.clubs[indexClub].goalAgainst = value['title'];
        } else if (indexString[indexString.length - 1] == '9') {
          this.clubs[indexClub].goalDifference = value['title'];
        }
      });

      this.clubs.asMap().forEach((index, club) { 
        print("DEBUG");
        print("Nom du club: " + club.name);
        print("Classement: " + (index + 1).toString());
        print("Matchs joués: " + club.matchesPlayed);
        print("Matchs gagnés: " + club.victories);
        print("Matchs nuls: " + club.draws);
        print("Matchs perdus: " + club.defeats);
        print("But pour: " + club.goalFor);
        print("But contre: " + club.goalAgainst);
        print("Différence de but: " + club.goalDifference);
        print("");
      });
    }
  }

  @override
  Widget build(BuildContext build) {
    this.clubs.removeRange(0, this.clubs.length);
    this.fetchClub();
    return (
      Container(
      )
    );
  }
}