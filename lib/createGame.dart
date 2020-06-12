import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolfapp/role.dart';

const _headerStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.0);

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
  int _toAddIndex = 0;

  static List<Role> _roles = [
    Role(
      "Villager",
      AssetImage('asset/villager.png'),
      'Villagers are meant to find and lynch the werewolf. The more villages the better.',
    ),
    Role(
      "Werewolf",
      AssetImage('asset/wolfpng.png'),
      "The Werewolf's goal is to kill every villager during the night. The Werewolf (or werewolves) may choose one minion.",
    ),
    Role(
      "Hunter",
      AssetImage('asset/hunter.png'),
      'Hunters are allowed one shot every night to kill a player in the game.',
    ),
    Role(
      "Mason",
      AssetImage('asset/mason.png'),
      'Masons are villagers who are aware of the identity of the other mason(s) in the game.',
    ),
    Role(
      "Seer",
      AssetImage('asset/seer.png'),
      'Seers are allowed to see the role of one player in the group every night.',
    ),
    Role(
      "Tanner",
      AssetImage('asset/tanner.png'),
      'Tanners are village team suicide bombers whose only goal is to get themselves lynched. Death by Werewolf does not count.',
    ),
  ];

  Map<String, int> _listCounts = {
    'Villager':0,
    'Werewolf':1,
    'Hunter':0,
    'Mason':0,
    'Seer':0,
    'Tanner':0,
  };

  List<Role> _listRoles = [
    _roles[1],
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
                setState(() => {_index = index, _toAddIndex = index}),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.8,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Image(width: 125, height: 125, image: _roles[i].img),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            top: 195, left: MediaQuery.of(context).size.width / 2 - 25),
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () =>
              setState(() => {
                if(_listCounts[_roles[_toAddIndex].name] == 0){
                  _listRoles.add(_roles[_toAddIndex])
                },
                _listCounts.update(_roles[_toAddIndex].name, (value) => value += 1),
//
//                if(_listRoles.containsKey(_roles[_toAddIndex])){
//                  _listRoles.update(_roles[_toAddIndex], (value) => value + 1)
//                }else{
//                  _listRoles[_roles[_toAddIndex]] = 0
//                }
              }),
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
      width: 300,
      height: 70,
      margin: EdgeInsets.fromLTRB(40, 40, 40, 10),
      child: SingleChildScrollView(child: Center(child: _roles[_index].info)),
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
              onTap: () => {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              title: Text(alertTitle),
                              content: Text(alertBody),
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
              child: Icon(
                Icons.help,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }

  Widget roleList() {
    return Center(
        child: Container(
          margin: EdgeInsets.only(top:10),
      height: 200,
      width: MediaQuery.of(context).size.width * .80,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _listRoles.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image(image: _listRoles[index].img, width: 30, height: 30),
                  Text(_listRoles[index].name, style: _subHeaderStyle),
                  Text('x${_listCounts[_listRoles[index].name]}'),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(thickness: 1.5, indent: 10.0, endIndent: 10.0,);
          },
        ),
      ),
    ));
  }

  Widget continueButton(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .65,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(12.0),
//          boxShadow: [BoxShadow(blurRadius: 1.0, spreadRadius: 1.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(0.5))]
      ),
      child: FlatButton(
        child: Text('Continue', style: TextStyle(color: Colors.white),),
        onPressed: () => {
          print('Tap')
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          titleBar(),
          roleDivider("Pick Possible Game Roles", 'Pick Role Help',
              'Clicking a role card will add it to the list of possible roles when the game begins.'),
          roleCards(),
          roleDescrips(),
          roleDivider("Current Active Roles", "Current Roles Help",
              "This list displays all the viable roles once you start the game. You must have enough players to satisfy these roles."),
          roleList(),
          continueButton(),
        ],
      ),
    ));
  }
}
