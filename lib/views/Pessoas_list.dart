import 'dart:convert';

import 'package:crud_pessoas/components/pessoa_tile.dart';
import 'package:crud_pessoas/model/pessoa.dart';
import 'package:crud_pessoas/provider/pessoas.dart';
import 'package:crud_pessoas/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PessoasList extends StatelessWidget {
  const PessoasList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pessoas pessoas = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista CRUD'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PESSOA_FROM,
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<Pessoa>>(
        future: pessoas.getPessoas(),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(
                child: Text(
                    'Alguma coisa de errado não esta certo :( ${snapshot.error}'));
          } else {
            return ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PessoaTile(snapshot.data![index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  indent: 20,
                  endIndent: 20,
                );
              },
            );
          }
        },
      ),
    );
  }
}
