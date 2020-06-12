import 'package:flutter/material.dart';

const _descripStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

class Role {
  String _descrip;
  Text info;
  String name;
  AssetImage img;

  Role(this.name, this.img, this._descrip){
    info = Text(_descrip, style: _descripStyle, textAlign: TextAlign.center);
  }
}