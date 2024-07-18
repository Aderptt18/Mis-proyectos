import 'package:eventos_uts/paginas_pantalla_principal/admin/agenda.dart';
import 'package:flutter/material.dart';
import 'paginas_pantalla_principal/admin/inicio.dart';
import 'paginas_pantalla_principal/admin/buscar.dart';
import 'paginas_pantalla_principal/admin/crear.dart';
import 'paginas_pantalla_principal/admin/perfil.dart';
import 'paginas_pantalla_principal/admin/cerrar.dart';

class pantalla_principal_admin extends StatefulWidget {
  @override
  State<pantalla_principal_admin> createState() =>
      _pantalla_principal_adminState();
}

class _pantalla_principal_adminState extends State<pantalla_principal_admin> {
  int _paginaActual = 0;

  // Lista de páginas correspondientes a cada ítem del BottomNavigationBar
  final List<Widget> _paginas = [
    pantallaPrincpipal_pagina_inicio_admin(),
    pantallaPrincpipal_pagina_buscar_admin(),
    pantallaPrincpipal_pagina_crear_admin(),
    pantallaPrincpipal_pagina_perfil_admin(),
    pantallaPrincpipal_pagina_agenda_admin(),
    pantallaPrincpipal_pagina_cerrar_admin()
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
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "crear"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda), label: "agenda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app), label: "cerrar")
        ],
        unselectedItemColor: Colors.green, //cuando nada esté selecccionado sea de color verde
        selectedItemColor: Colors.black, //cuando esté seleccionado sea de color negro
      ),
    );
  }
}
