import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolfapp/SizeConfig.dart';

import 'constants.dart';

class GameLobby extends StatefulWidget {
  Map<String, int> _roleList;
  Map<String, int> _timeList;
  String _lobbyName;
  String _hostUsername;
  int _roleCount = 0;

  GameLobby(
      this._roleList, this._lobbyName, this._hostUsername, this._timeList) {
    _roleList.forEach((_, val) => _roleCount += val);
  }

  @override
  _GameLobbyState createState() => _GameLobbyState();
}

class _GameLobbyState extends State<GameLobby> {

  Widget continueButton() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal),
      width: SizeConfig.safeBlockHorizontal * 80,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12.0),
//          boxShadow: [BoxShadow(blurRadius: 1.0, spreadRadius: 1.0, offset: Offset(0.0, 3.0), color: Colors.grey.withOpacity(0.5))]
      ),
      child: FlatButton(
        child: Text(
          'Start Game',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => {
          print("Tap"),
        },
      ),
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
              '${widget._lobbyName}',
              style: headerStyle,
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }

  Widget detailsEntry(String title, String key){
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.safeBlockVertical * 1.5),
                child: Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: SizeConfig.safeBlockHorizontal * 4,
                ),
              ),
              Text(title),
            ]),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical, bottom: SizeConfig.safeBlockVertical * 2),
          child: Text('${widget._timeList[key]}' + ' Min.'),
        )
      ],
    );
  }

  Widget details() {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2.5),
      width: SizeConfig.safeBlockHorizontal * 60,
      height: SizeConfig.safeBlockVertical * 24,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            detailsEntry("Daytime duration", "Daytime duration"),
            detailsEntry("Accusation duration", "Accuse duration"),
            detailsEntry("Defense duration", "Defense duration"),

//            Padding(
//              padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(right: SizeConfig.safeBlockVertical * 1.5),
//                      child: Icon(Icons.access_time, color: Colors.black, size: SizeConfig.safeBlockHorizontal * 4,)),
//                  Text('Daytime Duration:'),
//                  Expanded(child: Container(),),
//                  Text('${widget._timeList['Daytime duration']}' + ' Min.'),
//                  Divider(thickness: 2.0, color: Colors.grey)
//                ],
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                      padding: EdgeInsets.only(right: SizeConfig.safeBlockVertical * 1.5),
//                      child: Icon(Icons.access_time, color: Colors.black, size: SizeConfig.safeBlockHorizontal * 4,)),
//                  Text('Accusation Duration:'),
//                  Expanded(child: Container(),),
//                  Text('${widget._timeList['Accuse duration']}' + ' Min.'),
//                  Divider(thickness: 2.0, color: Colors.grey)
//                ],
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                      padding: EdgeInsets.only(right: SizeConfig.safeBlockVertical * 1.5),
//                      child: Icon(Icons.access_time, color: Colors.black, size: SizeConfig.safeBlockHorizontal * 4,)),
//                  Text('Defense Duration:'),
//                  Expanded(child: Container(),),
//                  Text('${widget._timeList['Defense duration']}' + ' Min.'),
//                  Divider(thickness: 2.0, color: Colors.grey)
//                ],
//              ),
//            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: <Widget>[
                titleBar(),
                roleDivider("Current Players", "Current Players Help",
                    "The players currently in your lobby will be assigned a role when the game starts. You need enough players to satisfy all roles."),
                PlayerList(widget._roleCount, widget._hostUsername,
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3)),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                  child: roleDivider("Details", "Details Help",
                      "All current options selected for this game instance. You may change these settings by going back and adjusting values."),
                ),
                details(),
                continueButton(),
              ],
            ),
          ),
    );
  }
}

class PlayerList extends StatefulWidget {
  int _count;
  EdgeInsets _margin;
  String _hostUsername;

  PlayerList(this._count, this._hostUsername, this._margin);

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  Widget build(BuildContext context) {
    return Container(
      margin: widget._margin,
      width: SizeConfig.safeBlockHorizontal * 80,
      height: SizeConfig.safeBlockVertical * 42.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
              offset: Offset(0.0, 3.0), blurRadius: 3.5, color: Colors.grey)
        ],
      ),
      child: Container(
          margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical,
                    bottom: SizeConfig.safeBlockVertical * 2),
                child: Text(
                  'Remaining Players: ' + '${widget._count - 1}',
                  style: playerListStyle,
                ),
              ),
              Container(
                width: SizeConfig.safeBlockHorizontal * 60,
                height: SizeConfig.safeBlockVertical * 32,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: index == 2
                                        ? Colors.lightBlueAccent
                                        : Colors.black,
                                  ),
                                  Expanded(
                                      child: index == 2
                                          ? Text(
                                              '${widget._hostUsername}',
                                              textAlign: TextAlign.center,
                                            )
                                          : Text(
                                              "player ${index}",
                                              textAlign: TextAlign.center,
                                            )),
                                  index == 2
                                      ? Icon(
                                          Icons.edit,
                                          size: SizeConfig.safeBlockHorizontal *
                                              4,
                                          color: Colors.grey,
                                        )
                                      : Container(
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  4,
                                        ),
                                ]));
                      },
                      separatorBuilder: (_, int index) {
                        return Divider(
                          thickness: 0,
                          indent: 1.5,
                          endIndent: 1.5,
                        );
                      },
                      itemCount: 20),
                ),
              ),
            ],
          )),
    );
  }
}
