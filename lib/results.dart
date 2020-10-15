import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'standings.dart';


class Results extends StatefulWidget {

  Results({Key key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}


class _ResultsState extends State<Results> {

  int _team = 1;
  int _competition = 1;
  String urlChampionship = '/recherche-clubs/?scl=16183&tab=resultats&subtab=ranking&competition=379649&stage=1&group=1&label=D1';


  @override
  Widget build(BuildContext build) {
      return (
        Column (
          children: [
            this.setChoicesTab(),
            Standings(championship: this.urlChampionship),
          ],
        )
        // Container(
        //   height: 300,
        //   child: ListView.builder(
        //     itemCount: this.clubName.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text(this.clubName[index]);
        //     },
        //   ),
        // )
      );      
    // return (
    //   Expanded(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SpinKitDoubleBounce(
    //           color: Color(0xff0a49a5)
    //         ),
    //         SizedBox(height: 20),
    //         Text('Veuillez patienter ...'),
    //       ],
    //     )
    //   )
    // );
  }

  Column setChoicesTab() {
    return (
      Column(
        children: [
          Container(
            width: double.infinity,
            color: Color(0xff0950b5),
            child: Center(
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Color(0xff0950b5)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white
                      ),
                      value: _team,
                      items: [
                        DropdownMenuItem(
                          child: Text("Équipe 1", style: TextStyle(color: Colors.white)),
                          value: 1,
                          onTap: () {
                            this.setState(() {
                              this.urlChampionship = "/recherche-clubs/?scl=16183&tab=resultats&subtab=ranking&competition=379649&stage=1&group=1&label=D1";
                            });
                          }
                        ),
                        DropdownMenuItem(
                          child: Text("Équipe 2", style: TextStyle(color: Colors.white)),
                          value: 2,
                          onTap: () {
                            this.setState(() {
                              this.urlChampionship = "/competitions/?id=378494&poule=1&phase=1&type=ch&tab=ranking";
                            });
                          }
                        ),
                        DropdownMenuItem(
                          child: Text("Équipe 3", style: TextStyle(color: Colors.white)),
                          value: 3,
                          onTap: () {
                            this.setState(() {
                              this.urlChampionship = "/competitions/?id=378495&poule=1&phase=1&type=ch&tab=ranking";
                            });
                          }
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _team = value;
                        });
                      }
                    ),                  
                  )
              )

            )
          ),
          Divider(
            color: Colors.white,
            height: 0.1,
          ),
          Container(
            width: double.infinity,
            color: Color(0xff0950b5),
            child: Center(
              child: IgnorePointer(
                ignoring: true,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white
                    ),
                    value: _competition,
                    items: [
                      DropdownMenuItem(
                        child: Text("Championnat", style: TextStyle(color: Colors.white)),
                        value: 1,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _competition = value;
                      });
                    }),
                  ),
              )
            )
          )
        ],
      )
    );
  }
}