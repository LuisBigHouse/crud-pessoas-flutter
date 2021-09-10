import 'package:crud_pessoas/model/pessoa.dart';
import 'package:crud_pessoas/provider/pessoas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class PessoaForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value!.trim().isNotEmpty) {
                    return null;
                  } else {
                    return "Digite o nome";
                  }
                },
                onSaved: (value) => _formData['nome'] = value!,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Idade',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Digite a idade";
                    // ignore: unrelated_type_equality_checks
                  } else if (int.tryParse(value) == false) {
                    return "Digite uma idade válida";
                  } else if (int.parse(value) < 0) {
                    return "Digite uma idade válida";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => _formData['idade'] = value!,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(double.infinity, 30),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Provider.of<Pessoas>(context, listen: false).createPessoa(
                        Pessoa(
                            nome: _formData['nome'],
                            idade: int.parse(_formData['idade'])),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
