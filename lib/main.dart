import 'package:crud_pessoas/provider/pessoas.dart';
import 'package:crud_pessoas/routes/app_routes.dart';
import 'package:crud_pessoas/views/Pessoa_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/Pessoas_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Pessoas(),
      child: MaterialApp(
        title: 'CRUD Pessoas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PessoasList(),
        routes: {
          AppRoutes.PESSOA_FORM: (_) => PessoaForm(),
        },
      ),
    );
  }
}
