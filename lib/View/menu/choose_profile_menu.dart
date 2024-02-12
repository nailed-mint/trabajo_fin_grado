import 'package:flutter/material.dart';

import 'package:trabajo_fin_grado/Controller/child_controller.dart';
import 'package:trabajo_fin_grado/Model/child_model.dart';
import 'package:trabajo_fin_grado/View/menu/create_profile_menu.dart';
import 'package:trabajo_fin_grado/View/menu/kid_menu.dart';

class ChooseProfileMenu extends StatefulWidget {
  const ChooseProfileMenu({super.key});

  @override
  ChooseProfileMenuState createState() => ChooseProfileMenuState();
}

class ChooseProfileMenuState extends State<ChooseProfileMenu> {
  late List<Child> profiles = [];

  @override
  void initState() {
    super.initState();
    listChild().then((value) => setState(() {
          profiles = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elige tu perfil"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            ...List.generate(
              profiles.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // TODO: set session of profile
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const KidMenu(), // Other menu screen redirection goes here
                      ),
                    );
                  },
                  child: Center(
                    widthFactor: 1.0,
                    child: Text(
                      "${profiles[index].name} ${profiles[index].surname} (${profiles[index].userType})",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateProfileMenu(),
                    ),
                  );
                },
                child: const Text("Crear nuevo perfil"))
          ]),
        ),
      ),
    );
  }
}
