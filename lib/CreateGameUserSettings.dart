import 'package:flutter/material.dart';
import 'package:werewolfapp/constants.dart';

class CreateGameUserSettings extends StatefulWidget{

  @override
  _CreateGameUserSettingsState createState() => _CreateGameUserSettingsState();
}

class _CreateGameUserSettingsState extends State<CreateGameUserSettings>{

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
        ],
      ),
    );
  }

}