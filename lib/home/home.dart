import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth/auth_service.dart';
import 'package:frontend/services/utility/router.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  @override
  State<MyHome> createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  final GlobalKey<NavigatorState> key = GlobalKey();
  int myindex = 0;

  @override
  void initState() {
    super.initState();
    AuthService.isLogged().then((value) => {
      if (!value) {Navigator.pushNamed(context, "/login")}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await AuthService.logOut();
                  Navigator.pushNamed(context, '/login');
                },
                child: const Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Navigator(
        key: key,
        initialRoute: '/family',
        onGenerateRoute: homeRoutes,
      ),
      bottomNavigationBar:
      BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business),
          label: 'Family',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.all_inbox_sharp),
          label: 'Material',
        ),
      ], currentIndex: myindex, onTap: _onItemTapped),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      myindex = index;
      switch (index) {
        case 0:
          key.currentState!.pushNamed('/family');
          break;
        case 1:
          key.currentState!.pushNamed('/material');
          break;
      }
    });
  }
}
