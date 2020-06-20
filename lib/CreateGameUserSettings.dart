import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolfapp/GameLobby.dart';
import 'package:werewolfapp/constants.dart';

import 'SizeConfig.dart';

typedef void IntCallback(int val);
typedef void StringCallback(String str);

class CreateGameUserSettings extends StatefulWidget {
  Map<String, int> _roleList; //Percolates to the next widget/

  CreateGameUserSettings(this._roleList);

  @override
  _CreateGameUserSettingsState createState() => _CreateGameUserSettingsState();
}

class _CreateGameUserSettingsState extends State<CreateGameUserSettings> {

  Map<String, int> createTimeMap(){

    Map<String, int> temp = {
      'Daytime duration': dayDuration,
      'Accuse duration': accuseDuration,
      'Defense duration': defenseDuration,
    };

    return temp;
  }

  int dayDuration = 2;
  int accuseDuration = 1;
  int defenseDuration = 1;
  String _userName = "";
  String _lobbyName = "";

  Widget startGameButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 17),
      width: SizeConfig.safeBlockHorizontal * 80,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: FlatButton(
        child: Text(
          'Continue',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => {
          if (_userName != "" && _lobbyName != "")
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>

                      GameLobby(widget._roleList, _lobbyName, _userName, createTimeMap())))
            }
          else
            {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Fill in all text fields.',
                ),
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.lightBlueAccent,
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                  },
                ),
              ))
            }
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
              'User Settings',
              style: headerStyle,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext innerContext) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              titleBar(),
              roleDivider("Daytime play duration", "Daytime Duration help",
                  "The amount of time allocated for deliberation during the day. Once time is up, accusations may begin."),
              Timer(
                (val) => {dayDuration = val},
                (val) => {dayDuration = val},
                dayDuration,
              ),
              roleDivider("Accusation Duration", "Accusation Duration Help",
                  "The amount of time allocated for the accuser to state their case."),
              Timer(
                (val) => {accuseDuration = val},
                (val) => {accuseDuration = val},
                accuseDuration,
              ),
              roleDivider("Defense Duration", "Defense Duration Help",
                  "The amount of time allocated for the accused to state their case."),
              Timer(
                (val) => {defenseDuration = val},
                (val) => {defenseDuration = val},
                defenseDuration,
              ),
              EntryBox(
                  (str) => {_userName = str},
                  "Enter a Username",
                  EdgeInsets.only(top: SizeConfig.safeBlockVertical * 15),
                  Icons.person),
              EntryBox(
                (str) => {_lobbyName = str},
                "Enter a Lobby Name",
                EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                Icons.assignment,
              ),
              startGameButton(innerContext),
            ],
          ),
        );
      }),
    );
  }
}

class Timer extends StatefulWidget {
  IntCallback updatePlus;
  IntCallback updateMinus;
  int _currTime;

  Timer(this.updatePlus, this.updateMinus, this._currTime);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
            child: IconButton(
              icon: Icon(Icons.minimize,
                  color: widget._currTime > 1
                      ? Colors.lightBlueAccent
                      : Colors.grey),
              onPressed: () => widget._currTime > 1
                  ? {
                      setState(() => widget._currTime -= 1),
                      widget.updateMinus(widget._currTime),
                    }
                  : {},
            ),
          ),
          Text('${widget._currTime}' +
              '${widget._currTime > 1 ? ' Minutes' : ' Minute'}'),
          IconButton(
            icon: Icon(
              Icons.add,
              color:
                  widget._currTime < 5 ? Colors.lightBlueAccent : Colors.grey,
            ),
            onPressed: () => widget._currTime < 5
                ? {
                    setState(() => widget._currTime += 1),
                    widget.updatePlus(widget._currTime),
                  }
                : {},
          ),
        ],
      ),
    );
  }
}

class EntryBox extends StatefulWidget {
  StringCallback _onChange;
  String _hint;
  EdgeInsets _margins;
  IconData _icon;
  bool _select = false;

  EntryBox(this._onChange, this._hint, this._margins, this._icon);

  @override
  _EntryBoxState createState() => _EntryBoxState();
}

class _EntryBoxState extends State<EntryBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget._margins,
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 3),
          child: Transform.scale(
            scale: widget._select ? 1.4 : 1.0,
            child: Icon(
              widget._icon,
              color: widget._select ? Colors.lightBlueAccent : Colors.black,
            ),
          ),
        ),
        Container(
            width: SizeConfig.safeBlockHorizontal * 60,
            height: SizeConfig.safeBlockVertical * 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey),
              shape: BoxShape.rectangle,
            ),
            child: TextField(
              maxLength: 10,
              onTap: () {
                setState(() {
                  widget._select = true;
                });
              },
              onChanged: (str) {
                widget._onChange(str);
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  widget._select = false;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: "",
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: widget._hint,
              ),
            )),
      ]),
    );
  }
}
