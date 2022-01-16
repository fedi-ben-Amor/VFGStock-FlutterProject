import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/login.dart';
import 'package:frontend/home/family/addfamily.dart';
import 'package:frontend/home/material/addmaterial.dart';
import 'package:frontend/home/material/listmaterial.dart';
import 'package:frontend/home/material/listmember.dart';
import 'package:frontend/home/material/material.dart';
import 'package:frontend/home/family/family.dart';
import 'package:frontend/home/family/listfamily.dart';

Route homeRoutes(RouteSettings setting) {
  late Widget page = const Login();
  switch (setting.name) {
    case '/family':
      page = const Family();
      break;
    case '/material':
      page = const MyMaterial();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: setting,
  );
}

Route familyRoute(RouteSettings setting) {
  late Widget page = const ListFamily();
  switch (setting.name) {
    case '/addFamily':
      page = const AddFamily();
      break;
    case '/listFamily':
      page = const ListFamily();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: setting,
  );
}

Route materialRoute(RouteSettings settings) {
  late Widget page = const ListMaterial();
  switch (settings.name) {
    case "/listMaterial":
      page = const ListMaterial();
      break;
    case '/addMaterial':
      page = const AddMaterial();
      break;
    case '/listMember':
      page = const ListMember();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
