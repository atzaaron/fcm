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

  
    if (await webScraper.loadWebPage('/recherche-clubs/?scl=16183&tab=resultats&subtab=ranking&competition=379649&stage=1&group=1&label=D1')) {
      List<Map<String, dynamic>> nameAndPoints = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-bold', []);
      List<Map<String, dynamic>> details = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-content', []);

      Club tmpClub;
      nameAndPoints.asMap().forEach((index, value) {
        //find name & points of the team
        if (index % 2 == 0) {
          // tmpClub = null;
          tmpClub = new Club(value['title']);
        }
        details.asMap().forEach((index, value) { 
          String indexString = index.toString();
          
          if (indexString[indexString.length - 1] == '1') {
            tmpClub.matchesPlayed = value['title'];
          } else if (indexString[indexString.length - 1] == '2') {
            tmpClub.victories = value['title'];
          } else if (indexString[indexString.length - 1] == '3') {
            tmpClub.draws = value['title'];
          } else if (indexString[indexString.length - 1] == '4') {
            tmpClub.defeats = value['title'];;
          } else if (indexString[indexString.length - 1] == '6') {
            tmpClub.goalFor = value['title'];
          } else if (indexString[indexString.length - 1] == '7') {
            tmpClub.goalAgainst = value['title'];
          } else if (indexString[indexString.length - 1] == '9') {
            tmpClub.goalDifference = value['title'];
          }
        });

        if (index % 2 != 0) {
          tmpClub.points = value['title'];
          this.clubs.add(tmpClub);
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