import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              enterCode(width, context),
              SizedBox(height: 25.0,),
              enterUsername(width, context),
              SizedBox(height: 25.0,),
              enterGame(width, context)
            ],
          ),
        ),
    );
  }
}

Widget enterCode(double width, BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 10),
    width: width * .65,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(blurRadius: 2.0, spreadRadius: 2.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(.5))]
    ),
    child: TextFormField(
        textAlign: TextAlign.center,
        decoration: new InputDecoration(hintText: "Enter Game Code", contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0))
    )
  );
}

Widget enterUsername(double width, BuildContext context){
  return Container(
      margin: EdgeInsets.only(top: 10),
      width: width * .65,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [BoxShadow(blurRadius: 2.0, spreadRadius: 2.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(.5))]
      ),
      child: TextFormField(
          textAlign: TextAlign.center,
          decoration: new InputDecoration(hintText: "Enter Username", contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0))
      )
  );
}

Widget enterGame(double width, BuildContext context){
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
      child: Text('Enter Game'),
      onPressed: () {
      },
    ),
  );
}