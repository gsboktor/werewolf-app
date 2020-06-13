import 'package:flutter/material.dart';

import 'constants.dart';



class Role {
  String _descrip;
  Text info;
  String name;
  AssetImage img;

  Role(this.name, this.img, this._descrip){
    info = Text(_descrip, style: descripStyle, textAlign: TextAlign.center);
  }
}