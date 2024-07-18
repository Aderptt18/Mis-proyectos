import 'package:eventos_uts/servicios/provider/datosEstudiante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class pantallaPrincpipal_pagina_perfil_estudiante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<datosEstudiante>(
      builder: (context, darkProvider, child) {
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
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/foto_perfil.png'),
                ),
                SizedBox(height: 20.0),
                Text(
                  darkProvider.getNombre(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  darkProvider.getCorreo(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ), 
              ],
            ),
          ),
        );
      },
    );
  }
}
