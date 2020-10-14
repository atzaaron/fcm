import 'package:fcm_results/club.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Standings extends StatefulWidget {

  Standings({Key key}) : super(key: key);

  @override
  _Standings createState() => _Standings();
}


class _Standings extends State<Standings> {

  List<Club> clubs = [];

  void initState() {
    super.initState();
    this.fetchClub().then((clubName) {
      setState(() {
        // this.clubName = clubName;
      });
    });
  }

  Future fetchClub() async {
    final webScraper = WebScraper('https://districtfootgers.fff.fr');
    String championnatD1 = '/recherche-clubs/?scl=16183&tab=resultats&subtab=ranking&competition=379649&stage=1&group=1&label=D1';
    String championnatD2 = '/competitions/?id=378494&poule=1&phase=1&type=ch&tab=ranking';

    if (await webScraper.loadWebPage(championnatD2)) {
      List<Map<String, dynamic>> nameAndPoints = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-bold', []);
      List<Map<String, dynamic>> details = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-content', []);

      Club tmpClub;
      nameAndPoints.asMap().forEach((index, value) {
        //find name & points of the team
        if (index % 2 == 0) {
          tmpClub = new Club(value['title']);
        } else {
          tmpClub.points = value['title'];
          this.clubs.add(tmpClub);
        }
      });

      int indexClub = 0;
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
    return (
      Container()
    );
  }
}