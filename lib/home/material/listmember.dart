import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/materiel.dart';
import 'package:frontend/models/membre.dart';
import 'package:frontend/services/materiell/materilservice.dart';
import 'package:frontend/services/utility/dialog.dart';

class ListMember extends StatefulWidget {
  const ListMember({Key? key}) : super(key: key);
  @override
  State<ListMember> createState() => _ListMember();
}

class _ListMember extends State<ListMember> {
  @override
  Widget build(BuildContext mycontext) {
    return FutureBuilder(
        future: Materielservice.getAllMember(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Member>> projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              !projectSnap.hasData) {
            return const Text("Aucune data");
          }

          return ListView.builder(
              itemCount: projectSnap.data!.length,
              itemBuilder: (context, index) {
                Widget memberType;
                if (projectSnap.data![index].dateReturn == null &&
                    projectSnap.data![index].state == null) {
                  memberType = Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Retourner emprunt'),
                        onPressed: () async {
                          await MyDialog.returnMaterialForm(
                              context, projectSnap.data![index]);
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  );
                } else {
                  memberType = Column(
                    children: <Widget>[
                      Chip(
                          avatar: const CircleAvatar(
                            backgroundColor: Colors.white70,
                            child: Text("D"),
                          ),
                          label: Text(
                              projectSnap.data![index].dateReturn.toString())),
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.white70,
                            child: Text(projectSnap.data![index].state![0]
                                .toUpperCase()),
                          ),
                          label: Text(projectSnap.data![index].state!)),
                    ],
                  );
                }
                return Column(
                  children: [
                    Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(
                              Icons.verified_user,
                              size: 30,
                              color: Color.fromARGB(255, 3, 152, 252),
                            ),
                            title: Text(
                                projectSnap.data![index].firstName! +
                                    " " +
                                    projectSnap.data![index].lastName!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            subtitle: Text(projectSnap.data![index].phoneNumber
                                .toString()),
                          ),
                          FutureBuilder<Materiel>(
                            future: Materielservice.getMaterialById(
                                projectSnap.data![index].idMaterial!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.none ||
                                  !snapshot.hasData) {
                                return const Text("Erreur");
                              }
                              return ListTile(
                                leading: const Icon(
                                  Icons.album,
                                  size: 30,
                                  color: Color.fromARGB(255, 3, 152, 252),
                                ),
                                title: Text(snapshot.data!.nomMateriel!),
                                subtitle: Text("Quantité : " +
                                    projectSnap.data![index].quantite
                                        .toString()),
                              );
                            },
                          ),
                          memberType,
                        ],
                      ),
                    ),
                  ],
                );
              });
        });
  }
}
