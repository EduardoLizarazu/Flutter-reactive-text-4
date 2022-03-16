import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'basic.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: inicio(),
    );
  }
}

class inicio extends StatefulWidget {
  inicio({Key? key}) : super(key: key);

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "aplication/json"});
    List map = json.decode(response.body);
    var basic = Basic.fromJson(map[1]);
    print("id");
    print(basic.id);
    print("title");
    print(basic.title);
    print("body");
    print(basic.body);
    idController.text = 'id ' + basic.id.toString();
    titleController.text = 'Titulo ' + basic.title.toString();
    bodyController.text = 'body ' + basic.body.toString();
    return 'okey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LizarazuApp'),
      ),
      body: ListView(children: <Widget>[
        Text("Programa manual"),
        TextFormField(
          controller: idController,
          readOnly: true,
          decoration:
              InputDecoration(hintText: "ID: ", border: InputBorder.none),
        ),
        TextFormField(
          controller: titleController,
          readOnly: true,
          decoration:
              InputDecoration(hintText: "Title: ", border: InputBorder.none),
        ),
        TextFormField(
          controller: bodyController,
          readOnly: true,
          decoration:
              InputDecoration(hintText: "Body: ", border: InputBorder.none),
        ),
        ElevatedButton(
            onPressed: getData, child: new Text('Llamando a servicio web'))
      ]),
    );
  }
}
