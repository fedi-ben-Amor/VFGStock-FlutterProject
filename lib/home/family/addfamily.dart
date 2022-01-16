import 'package:flutter/material.dart';
import 'package:frontend/services/utility/dialog.dart';
import 'package:frontend/models/famille.dart';
import 'package:frontend/services/family/familyservice.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);
  @override
  State<AddFamily> createState() => _MyFamilyState();
}

class _MyFamilyState extends State<AddFamily> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nomFamille;

  @override
  Widget build(BuildContext mycontext) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entrer Nom',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Entrer vote nom';
              }

              setState(() {
                nomFamille = value;
              });
            },
          ),
          ElevatedButton(
            child: const Text('Ajout'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool state =
                await Familyservice.add(Famille(familyname: nomFamille));
                await MyDialog.fullDialog(
                    context, state ? "AJOUT SUCCESS" : "Famille EXISTE");
                Familyservice.getAllFamily();
                if (state) {
                  Navigator.pushNamed(context,'/listFamily');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
