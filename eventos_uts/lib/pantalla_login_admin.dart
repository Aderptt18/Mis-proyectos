import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_uts/pantalla_principal_admin.dart';
import 'package:eventos_uts/servicios/provider/datosAdmin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class PantallaLoginAdmin extends StatefulWidget {
  @override
  _PantallaLoginAdminState createState() => _PantallaLoginAdminState();
}

class _PantallaLoginAdminState extends State<PantallaLoginAdmin> {
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

  Future<void> validarUsuario() async {
    try {
      final CollectionReference adminRef =
          FirebaseFirestore.instance.collection('admin');
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
          Provider.of<datosAdmin>(context, listen: false)
              .setDatos(adminNombre, adminCorreo);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pantalla_principal_admin()),
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
    return Consumer<datosAdmin>(builder: (context, darkProvider, child) {
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
            ],
          ),
        ),
      );
    });
  }
}
