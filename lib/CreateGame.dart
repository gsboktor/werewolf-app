import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolfapp/CreateGameUserSettings.dart';
import 'package:werewolfapp/main.dart';
import 'package:werewolfapp/role.dart';

import 'SizeConfig.dart';
import 'constants.dart';


class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  int _index = 0;
  int _toAddIndex = 0;


  Map<String, int> _listCounts = {
    'Villager': 0,
    'Werewolf': 1, // At least one werewolf is required for every game lobby.
    'Hunter': 0,
    'Mason': 0,
    'Seer': 0,
    'Tanner': 0,
  };

  List<Role> _listRoles = [
    roles[1], // Initialize list with one werewolf.
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
              style: headerStyle,
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
          height: SizeConfig.safeBlockVertical * 26.75, // card height
          child: PageView.builder(
            itemCount: 6,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) =>
                setState(() => {_index = index, _toAddIndex = index}),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.8,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 2,
                            bottom: SizeConfig.safeBlockVertical * 3,
                          ),
                          child: Image(
                              width: 35, height: 35, image: roles[i].img)),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 3,
                            right: SizeConfig.safeBlockHorizontal * 3),
                        child: roles[i].info,
                      )
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * 23.5,
          left: MediaQuery.of(context).size.width / 2 - 25,
          bottom: SizeConfig.safeBlockVertical,
        ),
        width: SizeConfig.safeBlockHorizontal * 11,
        height: SizeConfig.safeBlockVertical * 11,
        child: FloatingActionButton(
          onPressed: () => setState(() => {
                if (_listCounts[roles[_toAddIndex].name] == 0)
                  {_listRoles.add(roles[_toAddIndex])},
                _listCounts.update(
                    roles[_toAddIndex].name, (value) => value += 1),
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

//  Widget roleDescrips() {
//    return Container(
//      width: 300,
//      height: 70,
//      margin: EdgeInsets.fromLTRB(40, 40, 40, 10),
//      child: SingleChildScrollView(child: Center(child: _roles[_index].info)),
//    );
//  }

  Widget roleDivider(String title, String alertTitle, String alertBody) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: subHeaderStyle,
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
      margin: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * 2.5,
          bottom: SizeConfig.safeBlockVertical * 2.5),
      height: SizeConfig.safeBlockVertical * 30,
      width: SizeConfig.safeBlockHorizontal * 80,
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
                  Text(_listRoles[index].name, style: subHeaderStyle),
                  Text('x${_listCounts[_listRoles[index].name]}'),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1.25,
              indent: SizeConfig.safeBlockHorizontal * 2.25,
              endIndent: SizeConfig.safeBlockHorizontal * 2.25,
            );
          },
        ),
      ),
    ));
  }

  Widget continueButton() {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal),
      width: SizeConfig.safeBlockHorizontal * 80,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12.0),
//          boxShadow: [BoxShadow(blurRadius: 1.0, spreadRadius: 1.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(0.5))]
      ),
      child: FlatButton(
        child: Text(
          'Continue',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateGameUserSettings()))
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
//          roleDescrips(),
          roleDivider("Current Active Roles", "Current Roles Help",
              "This list displays all the viable roles once you start the game. You must have enough players to satisfy these roles."),
          roleList(),
          continueButton(),
        ],
      ),
    ));
  }
}
