import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/Model/user_model.dart';

class CreateProfileMenu extends StatefulWidget {
  const CreateProfileMenu({super.key});

  @override
  CreateProfileMenuState createState() => CreateProfileMenuState();
}

class CreateProfileMenuState extends State<CreateProfileMenu> {
  late List<User> families;
  UserType selectedUserType = UserType.child;

  CreateProfileMenuState(); // TODO: list families and then assign that value to the List

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creación de un perfil"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Apellido',
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButton<UserType>(
                value: selectedUserType,
                onChanged: (UserType? newValue) {
                  setState(() {
                    selectedUserType = newValue!;
                  });
                },
                items: UserType.values.map((UserType userType) {
                  return DropdownMenuItem<UserType>(
                    value: userType,
                    child: Text(userType.toString()),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement registration logic
                },
                child: const Text('Crear perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
