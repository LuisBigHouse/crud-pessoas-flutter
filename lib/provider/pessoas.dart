import 'dart:convert';

import 'package:crud_pessoas/model/pessoa.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

const URL = "Sua URL aqui";
const Map<String, String> HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};
const CONTROLLER = "Controlador aqui";

class Pessoas with ChangeNotifier {
  Future<List<Pessoa>> getPessoas() async {
    final response =
        await http.get(Uri.parse('$URL/$CONTROLLER'), headers: HEADERS);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Pessoa.fromJson(i))
          .toList();
    } else {
      throw Exception('Falha ao carregar lista');
    }
  }

  Future<Pessoa> getPessoa(int i) async {
    final response = await http.get(Uri.parse('$URL/$CONTROLLER/$i'));

    if (response.statusCode == 200) {
      notifyListeners();
      return Pessoa.fromJson(jsonDecode(response.body));
    } else {
      notifyListeners();
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<Pessoa?> createPessoa(pessoa) async {
    if (pessoa != null) {
      final response = await http.post(Uri.parse('$URL/$CONTROLLER'),
          headers: HEADERS,
          body: jsonEncode(<String, String>{
            'nome': pessoa.nome,
            'idade': pessoa.idade.toString(),
          }));
      if (response.statusCode == 201) {
        notifyListeners();
        return Pessoa.fromJson(json.decode(response.body));
      } else {
        notifyListeners();
        throw Exception('Falha ao criar pessoa');
      }
    }
    return null;
  }

  Future<Pessoa?> updatePessoa(pessoa) async {
    if (pessoa != null) {
      final response = await http.put(Uri.parse('$URL/$CONTROLLER'),
          headers: HEADERS,
          body: jsonEncode(<String, String>{
            'id': pessoa.id.toString(),
            'nome': pessoa.nome,
            'idade': pessoa.idade.toString(),
          }));
      if (response.statusCode == 200) {
        notifyListeners();
        return Pessoa.fromJson(json.decode(response.body));
      } else {
        notifyListeners();
        throw Exception('Falha ao alterar pessoa');
      }
    }
    return null;
  }

  void deletePessoa(pessoa) async {
    if (pessoa.id != null) {
      final response = await http.delete(
        Uri.parse('$URL/$CONTROLLER/${pessoa.id}'),
        headers: HEADERS,
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return;
      } else {
        notifyListeners();
        throw Exception('Falha ao deletar pessoa');
      }
    }
  }
}
