import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_uts/pantalla_register_estudiante.dart';
import 'package:eventos_uts/pantalla_principal_estudiante.dart';
import 'package:eventos_uts/servicios/provider/datosEstudiante.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PantallaInicioSesionEstudiante extends StatefulWidget {
  @override
  State<PantallaInicioSesionEstudiante> createState() =>
      _PantallaInicioSesionEstudianteState();
}

class _PantallaInicioSesionEstudianteState
    extends State<PantallaInicioSesionEstudiante> {
      TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

  Future<void> validarUsuario() async {
    try {
      final CollectionReference adminRef =
          FirebaseFirestore.instance.collection('estudiantes');
      final QuerySnapshot adminSnapshot = await adminRef.get();
      final List<DocumentSnapshot> adminDocs = adminSnapshot.docs;

      // Validar que los campos de correo y contraseña no estén vacíos
      if (correoController.text.isEmpty || contrasenaController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, complete todos los campos')),
        );
        return;
      }

      for (final adminDoc in adminDocs) {
        final String adminCorreo = adminDoc.get('Correo');
        final String adminContrasena = adminDoc.get('Contraseña');
        final String adminNombre = adminDoc.get('Nombre');
        if (adminCorreo == correoController.text &&
            adminContrasena == contrasenaController.text) {
          Provider.of<datosEstudiante>(context, listen: false)
              .setDatos(adminNombre, adminCorreo);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pantalla_principal_estudiante()),
          );
          return;
        }
      }

      // Mostrar mensaje de error si las credenciales son incorrectas
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correo electrónico o contraseña incorrectos')),
      );
    } catch (e) {
      // Manejar errores específicos
      print('Error al validar usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al validar usuario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<datosEstudiante>(builder: (context, darkProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse("0xFFBADD73")),
          title: Text('Ingreso'),
        ),
        backgroundColor: Color(int.parse("0xFFBADD73")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: TextField(
                  controller: correoController,
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  controller: contrasenaController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    validarUsuario();
                  },
                  child: Text('Ingresar'),
                ),
              ),

              Container(
              width: 150,
              child: ElevatedButton(
                //para ir de una pantalla a otra
                onPressed: () {
                  // Navegamos a la pantalla de login de administradores al hacer clic en el botón
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PantallaRegisterEstudiante()),
                  );
                },
                child: Text('Crear cuenta'),
              ),
          )],
          ),
        ),
      );
    });
  }
}


  


  