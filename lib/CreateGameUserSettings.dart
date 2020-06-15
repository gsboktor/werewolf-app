import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolfapp/constants.dart';

import 'SizeConfig.dart';

typedef void IntCallback(int val);
typedef void StringCallback(String str);

class CreateGameUserSettings extends StatefulWidget {
  @override
  _CreateGameUserSettingsState createState() => _CreateGameUserSettingsState();
}

class _CreateGameUserSettingsState extends State<CreateGameUserSettings> {
  int dayDuration = 2;
  int accuseDuration = 1;
  int defenseDuration = 1;
  String _userName = "";

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
      body: Column(
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
          EntryBox((str) => {_userName = str}, "Enter a Username", EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5)),
        ],
      ),
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

class EntryBox extends StatelessWidget {
  StringCallback _onChange;
  String _hint;
  EdgeInsets _margins;

  EntryBox(this._onChange, this._hint, this._margins);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: _margins,
        width: SizeConfig.safeBlockHorizontal * 60,
        height: SizeConfig.safeBlockVertical * 4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey),
            shape: BoxShape.rectangle,
        ),
        child: TextField(
          onChanged: (str){_onChange(str);},
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: _hint,
          ),
        ));
  }
}
