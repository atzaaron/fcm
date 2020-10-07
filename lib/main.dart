import 'package:fcm_results/articles.dart';
import 'package:fcm_results/results.dart';
import 'package:flutter/material.dart';
import 'club.dart';
import 'admin_page.dart';


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

  List<Club> clubs = List();
  int currentPage = 0;

  void managePage(int page) {
    this.setState(() {
      this.currentPage = page;
    });

  }

  displayContent() {
    if (this.currentPage == 1)
      return Results();
    else
      return Articles();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Color(0xff0a49a5),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Développeur: Aaron Centeno"),
              accountEmail: Text("Contact: aaron.centeno@outlook.com"),
              decoration: BoxDecoration(
                color: Color(0xff0950b5),
              ),
              currentAccountPicture: CircleAvatar(
                child: Image.asset('assets/images/logo_fcm.png'),
                backgroundColor: Color(0xff0950b5),
                
              ),
            ),
            ListTile(
              title: Text('Accès administrateur'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => new AdminPage() 
                ));
              }
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            this.displayContent()
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Articles'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Résultats'
          )
        ],
        backgroundColor: Color(0xff0a49a5),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        currentIndex: this.currentPage,
        onTap: this.managePage,
      ),
    );
  }
}
