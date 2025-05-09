import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class WidgetNewResearch extends StatefulWidget {
  @override
  _WidgetNewResearch createState() {
    return _WidgetNewResearch();
  }
}

class _WidgetNewResearch extends State<WidgetNewResearch> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _titleField = TextEditingController();
  var _author = '';
  var _authorField = TextEditingController();
  var _description = '';
  var _descriptionField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(hintText: 'Título do Trabalho'),
              onSaved: (newValue) => _title = _titleField.text,
              validator: (currentValue) {
                return 'Título Inválido'; // Define Validator
              }),
          TextFormField(
              decoration: const InputDecoration(hintText: 'Autor do Trabalho'),
              onSaved: (newValue) => _author = _authorField.text,
              validator: (currentValue) {
                return 'Autor Inválido'; // Define Validator
              }),
          TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Descrição do Trabalho'),
              onSaved: (newValue) => _description = _descriptionField.text,
              validator: (currentValue) {
                return 'Descrição Inválida'; // Define Validator
              }),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(hintText: 'Tipo'),
            validator: (currentValue) {
              return 'Tipo Inválido';
            },
            items: const [
              DropdownMenuItem(value: '1', child: Text('Artigo')),
              DropdownMenuItem(value: '2', child: Text('Pesquisa')),
              DropdownMenuItem(value: '3', child: Text('Extensão')),
              DropdownMenuItem(value: '4', child: Text('Dissertação')),
              DropdownMenuItem(value: '5', child: Text('TCC'))
            ],
            onChanged: (value) {},
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: const Text('Enviar'))
        ],
      ),
    ));
  }
}
