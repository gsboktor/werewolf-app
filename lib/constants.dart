
import 'package:flutter/material.dart';
import 'package:werewolfapp/role.dart';


List<Role> roles = [
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

const TextStyle headerStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.0);

const TextStyle subHeaderStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w300,
);

const TextStyle descripStyle = TextStyle(
  color: Colors.grey,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const TextStyle titleStyle = TextStyle(color: Colors. black, fontSize: 28, letterSpacing: 2.0, fontWeight: FontWeight.w600);