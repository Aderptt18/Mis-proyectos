import 'package:eventos_uts/servicios/provider/datosAdmin.dart';
import 'package:flutter/material.dart';
//importamos la página de ingreso para que el usuario salga de la pantalla principal
import 'package:eventos_uts/pantalla_ingreso.dart';
import 'package:provider/provider.dart';

class pantallaPrincpipal_pagina_cerrar_admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<datosAdmin>(builder: (context, registroProvider, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(int.parse("0xFFBADD73")),
            automaticallyImplyLeading:
                false, // Esto quita la flecha de retroceso
          ),
          backgroundColor: Color(int.parse("0xFFBADD73")),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text('¿Deseas cerrar sesión?'),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  print(registroProvider.getRegistrado());
                  registroProvider.setRegistro();
                  // Navegamos a la pantalla de login de estudiantes al hacer clic en el botón
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantallaIngreso()),
                  );
                  print(registroProvider.getRegistrado());
                },
                child: Text('CERRAR SESIÓN'),
              ),
            ],
          )));
    });
  }
}
