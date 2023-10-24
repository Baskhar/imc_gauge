import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imc_gauge/app/screens/home/home_screen.dart';




class AppModule extends Module {
  @override
  List<Bind> get binds => [
    //Bind.singleton((i) => ListPessoaModel()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/home', child: (_, __) => HomeScreen()),

  ];
}