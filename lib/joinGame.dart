import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolfapp/lobby.dart';

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                enterCode(width, context),
                SizedBox(height: 25.0,),
                enterUsername(width, context),
                SizedBox(height: 25.0,),
                enterGame(width, context, _formKey)
              ],
            ),
          ),
        ),
    );
  }
}

Widget titleBar(BuildContext context) {
  return SafeArea(
    child: Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {Navigator.pop(context);},
          ),
          Text(
            'Game Settings',
          )
        ],
      ),
    ),
  );
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
      validator: (value) {
        if (value.length == 5) {
          return 'Please enter a valid code';
        }
        return null;
      },
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
        validator: (value) {
          if (value.length >= 6) {
            return 'Please enter a valid username';
          }
          return null;
        },
          textAlign: TextAlign.center,
          decoration: new InputDecoration(hintText: "Enter Username", contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0))
      )
  );
}

Widget enterGame(double width, BuildContext context, GlobalKey<FormState> _formKey){
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
        if (_formKey.currentState.validate()) {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LobbyPage()));
        }
      },
    ),
  );
}