import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Results extends StatefulWidget {

  Results({Key key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}


class _ResultsState extends State<Results> {

  List<String> clubName = [];
  int _team = 1;
  int _competition = 1;

  void initState() {
    super.initState();
    this.fetchClub().then((clubName) {
      setState(() {
        this.clubName = clubName;
      });
    });
  }


  Future fetchClub() async {
    List<String> clubName = List();
    final webScraper = WebScraper('https://districtfootgers.fff.fr');
  
    if (await webScraper.loadWebPage('/recherche-clubs/?scl=16183&tab=resultats&subtab=ranking&competition=379649&stage=1&group=1&label=D1')) {
        List<Map<String, dynamic>> elements = webScraper.getElement('table.ranking-tab > tbody > tr > td.ranking-tab-bold', []);
        // print(elements);
        elements.forEach((name) {
          if (!isNumeric(name['title'][0])) {
            // this.clubs.add()
            clubName.add(name['title']);
          }
        });
        return clubName;
    }
  }

  @override
  Widget build(BuildContext build) {
    if (this.clubName.length > 0) {
      return (
        this.setChoicesTab()
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
    }
    return (
      Expanded(
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

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
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
                        ),
                        DropdownMenuItem(
                          child: Text("Équipe 2", style: TextStyle(color: Colors.white)),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Équipe 3", style: TextStyle(color: Colors.white)),
                          value: 3
                        )
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