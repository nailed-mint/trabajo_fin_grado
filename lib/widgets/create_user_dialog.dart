import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/models/user.dart';

class CreateUserWidget extends StatefulWidget {
  final User? user;
  final Function(String name, String type) onSubmit;

  const CreateUserWidget({
    super.key,
    this.user,
    required this.onSubmit,
  });

  @override
  State<CreateUserWidget> createState() => _CreateUserWidgetState();
}

class _CreateUserWidgetState extends State<CreateUserWidget> {
  final formKey = GlobalKey<FormState>();
  int? idValue;
  final nameController = TextEditingController();
  String? typeDropdownValue;
  String? emailValue;

  @override
  void initState() {
    super.initState();

    idValue = widget.user?.id ?? 0;
    nameController.text = widget.user?.name ?? '';
    typeDropdownValue = widget.user?.type;
    emailValue = widget.user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;
    return userForm(isEditing, context);
  }

  AlertDialog userForm(bool isEditing, BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Editar Usuario' : 'Crear Usuario'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(idValue.toString()),
            TextFormField(
              autofocus: true,
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Nombre'),
              validator: (value) => value != null && value.isEmpty
                  ? 'El nombre es obligatorio'
                  : null,
            ),
            DropdownButtonFormField<String>(
              value: typeDropdownValue,
              decoration: const InputDecoration(hintText: 'Tipo de Usuario'),
              onChanged: (String? newValue) {
                typeDropdownValue = newValue;
              },
              items: ['child', 'family', 'professional']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) => value == null || value.isEmpty
                  ? 'Debe seleccionar un tipo de usuario'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.onSubmit(nameController.text, typeDropdownValue!);
            }
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
