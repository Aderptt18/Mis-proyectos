import 'package:flutter/material.dart';
import 'package:eventos_uts/paginas_pantalla_principal/estudiante/inicio.dart';
import 'package:eventos_uts/paginas_pantalla_principal/estudiante/cerrar.dart';
import 'package:eventos_uts/paginas_pantalla_principal/estudiante/agenda.dart';
import 'package:eventos_uts/paginas_pantalla_principal/estudiante/perfil.dart';
import 'package:eventos_uts/paginas_pantalla_principal/estudiante/buscar.dart';

class pantalla_principal_estudiante extends StatefulWidget {
  @override
  State<pantalla_principal_estudiante> createState() =>
      _pantalla_principal_estudianteState();
}

class _pantalla_principal_estudianteState extends State<pantalla_principal_estudiante> {
  int _paginaActual = 0;

  // Lista de páginas correspondientes a cada ítem del BottomNavigationBar
  final List<Widget> _paginas = [
    pantallaPrincpipal_pagina_inicio_estudiante(),
    pantallaPrincpipal_pagina_buscar_estudiante(),
    pantallaPrincpipal_pagina_agenda_estudiante(),
    pantallaPrincpipal_pagina_perfil_estudiante(),
    pantallaPrincpipal_pagina_cerrar_estudiante()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "buscar"),
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda), label: "agenda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "perfil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app), label: "cerrar")
        ],
        unselectedItemColor: Colors.green,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
