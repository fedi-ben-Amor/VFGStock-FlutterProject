import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:frontend/services/utility/router.dart';

class Family extends StatefulWidget {
  const Family({Key? key}) : super(key: key);
  @override
  State<Family> createState() => MyFamilyState();
}

class MyFamilyState extends State<Family> {
  final GlobalKey<NavigatorState> key = GlobalKey();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          body: Navigator(
              key: key,
              initialRoute: '/listFamily',
              onGenerateRoute: familyRoute),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            openCloseDial: isDialOpen,
            backgroundColor: Colors.black,
            overlayColor: Colors.grey,
            overlayOpacity: 0.5,
            spacing: 15,
            spaceBetweenChildren: 15,
            closeManually: true,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.list),
                  label: 'Liste Famille',
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  onTap: () {
                    setState(() {
                      isDialOpen.value = false;
                    });
                    key.currentState!.pushNamed('/listFamily');
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.add),
                  label: 'Ajouter Famille',
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  onTap: () {
                    setState(() {
                      isDialOpen.value = false;
                    });
                    key.currentState!.pushNamed('/addFamily');
                  }),
            ],
          )),
    );
  }
}
