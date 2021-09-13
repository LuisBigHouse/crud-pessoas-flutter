import 'package:crud_pessoas/model/pessoa.dart';
import 'package:crud_pessoas/provider/pessoas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PessoaTile extends StatelessWidget {
  final Pessoa pessoa;

  const PessoaTile(this.pessoa);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pessoa.nome),
      subtitle: Text("Idade: " + pessoa.idade.toString()),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  _modalUpdate(
                    pessoa: pessoa,
                    context: context,
                  );
                },
                color: Colors.orange[300],
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  _modalDelete(
                    pessoa: pessoa,
                    context: context,
                  );
                },
                color: Colors.red[300],
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}

_modalUpdate({required Pessoa pessoa, required BuildContext context}) {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("Alterar"),
        content: Form(
          key: _formKey,
          child: Wrap(
            children: <Widget>[
              TextFormField(
                initialValue: pessoa.nome,
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
                initialValue: pessoa.idade.toString(),
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
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Provider.of<Pessoas>(context, listen: false).updatePessoa(
                  Pessoa(
                      id: pessoa.id,
                      nome: _formData['nome'],
                      idade: int.parse(_formData['idade'])),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("${_formData['nome']} alterado com sucesso!")));
                Navigator.pop(context);
              }
            },
            child: Text('Alterar'),
          ),
        ],
      );
    },
  );
}

_modalDelete({required Pessoa pessoa, required BuildContext context}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("Excluir"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Tem certeza que deseja excluir ${pessoa.nome}?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Sim'),
            onPressed: () {
              Provider.of<Pessoas>(context, listen: false).deletePessoa(pessoa);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${pessoa.nome} excluido com sucesso!")));
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Não'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
