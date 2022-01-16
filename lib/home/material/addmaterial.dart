import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/famille.dart';
import 'package:frontend/models/materiel.dart';
import 'package:frontend/services/family/familyservice.dart';
import 'package:frontend/services/materiell/materilservice.dart';
import 'package:frontend/services/utility/dialog.dart';

class AddMaterial extends StatefulWidget {
  const AddMaterial({Key? key}) : super(key: key);
  @override
  State<AddMaterial> createState() => _MymatState();
}

class _MymatState extends State<AddMaterial> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nomMateriel;
  int? qnt;
  DateTime? dateA;
  String? nomF;
  List<Famille>? allFamily;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext mycontext) {
    return Form(
        key: _formKey,
        child: FutureBuilder<List<Famille>>(
          future: Familyservice.getAllFamily(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Famille>> snapshot) {
            Widget children;
            if (snapshot.hasData) {
              children = DropdownButton<String>(
                value: nomF,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                hint: const Text("Choisir votre famille"),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: snapshot.data!.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem<String>(
                    alignment: AlignmentDirectional.center,
                    value: e.familyname,
                    child: Text(e.familyname!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    nomF = value;
                  });
                },
              );
            } else {
              children = const Text('Famille non trouvée');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Saisir le nom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "S'il vous plait tapez le nom";
                    }
                    setState(() {
                      nomMateriel = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Taper la quantité',
                  ),
                  validator: (String? value) {
                    if (value == null) {
                      return "S'il vous plait tapez le nom";
                    }
                    setState(() {
                      qnt = int.parse(value);
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? date = await MyDialog.dateDialog(context);
                      setState(() {
                        dateA = date;
                      });
                    },
                    child: const Text("Date d'acquition")),
                children,
                ElevatedButton(
                  child: const Text('Ajouter'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool state = await Materielservice.add(
                          Materiel.create(nomMateriel, qnt, dateA, nomF));
                      state
                          ? MyDialog.fullDialog(context, "Materiel bien ajouté")
                          : MyDialog.fullDialog(context, "Erreur");
                    }
                  },
                ),
              ],
            );
          },
        ));
  }
}
