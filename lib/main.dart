import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'club.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Football Club Mirandais'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> clubName = [];
  List<Club> clubs = List();

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
  Widget build(BuildContext context) {
    if (this.clubName.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Color(0xff0a49a5),
          actions: <Widget>[
            IconButton(
              onPressed: () { print("to do Accès administrateur");},
              icon: Icon(Icons.settings),
              color: Colors.white,
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Développeur: Aaron Centeno"),
                accountEmail: Text("Contact: aaron.centeno@outlook.com")
              )
            ],
          ),
        ),
        body: Center(
          child: Card(
            child: ListView.builder(
              itemCount: this.clubName.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(this.clubName[index]);
              },
            ),
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
      );
    }
    
    return (
      Text('waiting ...')
    );
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
