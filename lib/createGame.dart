import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _headerStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.0);

const _descripStyle = TextStyle(
  color: Colors.grey,
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

const _subHeaderStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w300,
);

class CreateGame extends StatefulWidget {
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  int _index = 0;
  int _descripIndex = 0;
  int _toAddIndex = 0;

  List<AssetImage> imgs = [
    AssetImage('asset/villager.png'),
    AssetImage('asset/wolfpng.png'),
    AssetImage('asset/hunter.png'),
    AssetImage('asset/mason.png'),
    AssetImage('asset/seer.png'),
    AssetImage('asset/tanner.png'),
  ];

  List<Text> descrip = [
    Text(
      'Villagers are meant to find and lynch the werewolf. The more villages the better.',
      style: _descripStyle,
      textAlign: TextAlign.center,
    ),
    Text(
      "The Werewolf's goal is to kill every villager during the night. The Werewolf (or werewolves) may choose one minion.",
      style: _descripStyle,
      textAlign: TextAlign.center,
    ),
    Text(
        'Hunters are allowed one shot every night to kill a player in the game.',
        style: _descripStyle,
        textAlign: TextAlign.center),
    Text(
        'Masons are villagers who are aware of the identity of the other mason(s) in the game.',
        style: _descripStyle,
        textAlign: TextAlign.center),
    Text(
        'Seers are allowed to see the role of one player in the group every night.',
        style: _descripStyle,
        textAlign: TextAlign.center),
    Text(
        'Tanners are village team suicide bombers whose only goal is to get themselves lynched. Death by Werewolf does not count.',
        style: _descripStyle,
        textAlign: TextAlign.center)
  ];

  Widget titleBar() {
    return SafeArea(
      child: Container(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => {Navigator.pop(context)},
            ),
            Text(
              'Game Settings',
              style: _headerStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget roleCards() {
    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 200, // card height
          child: PageView.builder(
            itemCount: 6,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) =>
                setState(() =>
                {_index = index, _descripIndex = index, _toAddIndex = index}),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Image(width: 125, height: 125, image: imgs[i])),
                ),
              );
            },
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            top: 195, left: MediaQuery
            .of(context)
            .size
            .width / 2 - 25),
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () => {print('tap2')},
          elevation: 12.0,
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35.0,
          ),
        ),
      ),
    ]);
  }

  Widget roleDescrips() {
    return Container(
      margin: EdgeInsets.all(40.0),
      child: Center(child: descrip[_descripIndex]),
    );
  }

  Widget roleDivider(String title, String alertTitle, String alertBody) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: _subHeaderStyle,
          ),
          GestureDetector(
              onTap: () =>
              {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) =>
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                          title: Text(alertTitle),
                          content: Text(
                              alertBody),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )),
              },
              child: Icon(Icons.help, color: Colors.grey,)),
        ],
      ),
    );
  }

  Widget roleList() {
    return Container();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              titleBar(),
              roleDivider("Pick Possible Game Roles", 'Pick Role Help', 'Clicking a role card will add it to the list of possible roles when the game begins.'),
              roleCards(),
              roleDescrips(),
              roleDivider("Current Active Roles", "Current Roles Help", "This list displays all the viable roles once you start the game. You must have enough players to satisfy these roles."),
              roleList(),
            ],
          ),
        ));
  }
}
