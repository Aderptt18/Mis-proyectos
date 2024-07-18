import 'package:eventos_uts/pantalla_principal_admin.dart';
import 'package:eventos_uts/pantalla_principal_estudiante.dart';
import 'package:eventos_uts/servicios/provider/datosAdmin.dart';
import 'package:eventos_uts/servicios/provider/datosEstudiante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pantalla_login_admin.dart'; //importacion de la pantalla de inicio de sesion del administrador
import 'pantalla.inicioSesion_estudiante.dart';

class PantallaIngreso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<datosAdmin>(builder: (context, registroProvider, child) {
      return Consumer<datosEstudiante>(
          builder: (context, registroProviderEstu, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(int.parse(
                "0xFFBADD73")), //color de fondo de la parte de las notificaciones
            automaticallyImplyLeading:
                false, // Esto quita la flecha de retroceso
          ),
          backgroundColor:
              Color(int.parse("0xFFBADD73")), //color de fondo de la pantalla
          body: Center(
            //para centrar los wodgets
            child: Column(
              //para que los widges se coloquen en forma de columna
              mainAxisAlignment: MainAxisAlignment
                  .center, //ordena todo en el centro de la pantlla
              children: [
                //para agregar varios widgets
                Container(
                  //widget es para el logo de la app
                  width: 250, // Ancho del contenedor
                  height: 250, // Altura del contenedor
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'), // Ruta de la imagen
                      fit: BoxFit
                          .cover, // Ajusta la imagen para cubrir el contenedor
                    ),
                  ),
                ),
                SizedBox(height: 100), // Espacio entre los botones
                Container(
                  width: 175,
                  child: ElevatedButton(
                    onPressed: () {
                      if (registroProvider.getRegistrado()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pantalla_principal_admin()),
                        );
                      } else {
                        // Navegamos a la pantalla de login de estudiantes al hacer clic en el botón
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PantallaLoginAdmin()),
                        );
                      }
                    },
                    child: Text('Administrador'),
                  ),
                ),
                SizedBox(height: 10), // Espacio entre los botones
                Container(
                  width: 175,
                  child: ElevatedButton(
                    //para ir de una pantalla a otra
                    onPressed: () {
                      if (registroProviderEstu.getRegistrado()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pantalla_principal_estudiante()),
                        );
                      } else {
                        // Navegamos a la pantalla de login de estudiantes al hacer clic en el botón
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PantallaInicioSesionEstudiante()),
                        );
                      }
                    },
                    child: Text('Estudiante'),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
