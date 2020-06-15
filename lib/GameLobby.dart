import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class GameLobby extends StatefulWidget{
  Map<String, int> _roleList;
  String _lobbyName;
  String _hostUsername;

  GameLobby(this._roleList, this._lobbyName, this._hostUsername);

  @override
  _GameLobbyState createState() => _GameLobbyState();
}

class _GameLobbyState extends State<GameLobby>{

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
              'Game Lobby',
              style: headerStyle,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            titleBar(),
            Text('${widget._roleList}'),
            Text('${widget._lobbyName}' + '${widget._hostUsername}')
          ],
        ),
      ),
    );
  }
}