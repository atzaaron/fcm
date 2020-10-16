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
  bool reloadingStandings = false;

  Future fetchClub() async {
    final webScraper = WebScraper('https://districtfootgers.fff.fr');

    this.setState(() {
      this.reloadingStandings = true;
    });
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
        // if (indexString[indexString.length - 1] == '0') {
          // this.clubs[indexClub].standing = value['title'];
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

      //UNCOMMENT FOR DEBUG
      // this.clubs.asMap().forEach((index, club) { 
      //   print("DEBUG");
      //   print("Nom du club: " + club.name);
      //   print("Classement: " + (index + 1).toString());
      //   print("Matchs joués: " + club.matchesPlayed);
      //   print("Matchs gagnés: " + club.victories);
      //   print("Matchs nuls: " + club.draws);
      //   print("Matchs perdus: " + club.defeats);
      //   print("But pour: " + club.goalFor);
      //   print("But contre: " + club.goalAgainst);
      //   print("Différence de but: " + club.goalDifference);
      //   print("");
      // });
    }
    this.setState(() {
      this.reloadingStandings = false;
    });
  }

  @override
  Widget build(BuildContext build) {
    if (this.urlChampionship != widget.championship) {
      this.clubs.removeRange(0, this.clubs.length);
      this.fetchClub();
    }

    if (this.clubs.length > 0 && !this.reloadingStandings) {
      return (
        Container(
          height: MediaQuery.of(build).size.height * 0.65,
          child: ListView.builder(
            itemCount: this.clubs.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(0),
                height: 45,
                child: Card(
                  color: this.clubs[index].name.contains("MIRANDE") ? Color(0xff0a49a5) : Colors.grey[300],
                  margin: EdgeInsets.only(left: 5, right: 5, top: 2.5, bottom: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(this.clubs[index].standing),
                      Text(this.clubs[index].name, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].points, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].matchesPlayed, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].victories, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].draws, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].defeats, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].goalFor, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].goalAgainst, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                      Text(this.clubs[index].goalDifference, style: TextStyle(color: this.clubs[index].name.contains("MIRANDE") ? Colors.white : Colors.black)),
                    ],
                  )
                )
              );
            },
          ),
        )
      );
    }

    return (
      Container(
        height: MediaQuery.of(build).size.height * 0.55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(
              color: Color(0xff0a49a5)
            ),
            SizedBox(height: 20),
            Text('Veuillez patienter ...'),
          ],
        )
      )
    );
  }
}