import 'package:flutter/material.dart';

import 'createGame.dart';

const _titleStyle = TextStyle(color: Colors. black, fontSize: 28, letterSpacing: 2.0, fontWeight: FontWeight.w600);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  Widget build(BuildContext context){

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            logo(),
            title("Werewolf"),
            buttons(width, context),
          ],
        ),
      )
    );
  }
}

Widget logo(){
  return Container(
    margin: EdgeInsets.only(top: 100),
    width: 225,
    height: 225,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 4.0, spreadRadius: 1.0, offset: Offset(0.0, 3.0))]
    ),
    child: FittedBox(fit: BoxFit.fill, child: Image(width: 175, height: 175, image: AssetImage('asset/wolfpng.png'))),
    alignment: Alignment.center,
  );
}

Widget title(String title){
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: Text(title, style: _titleStyle,),
  );
}

Widget buttons(double width, BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      createGame(width, context),
      joinGame(width),
    ],
  );
}

Widget createGame(double width, BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 200),
    width: width * .65,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [BoxShadow(blurRadius: 2.0, spreadRadius: 2.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(.5))]
    ),
    child: FlatButton(
      child: Text('Create Game'),
      onPressed: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateGame()))
      },
    ),
  );
}

Widget joinGame(double width){
  return Container(
    margin: EdgeInsets.only(top: 10),
    width: width * .65,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(blurRadius: 2.0, spreadRadius: 2.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(.5))]
    ),
    child: FlatButton(
      child: Text('Join Game'),
      onPressed: () => {
        print('Tap')
      },
    ),
  );
}
