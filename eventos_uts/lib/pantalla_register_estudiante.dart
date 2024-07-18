import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaRegisterEstudiante extends StatefulWidget {
  @override
  _PantallaRegisterEstudianteState createState() =>
      _PantallaRegisterEstudianteState();
}

class _PantallaRegisterEstudianteState
    extends State<PantallaRegisterEstudiante> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  final firebase = FirebaseFirestore.instance; //istancia de firestore
  registroUsuario() async {
    try {
      await firebase.collection('estudiantes').doc().set({
        "Nombre": nombre.text,
        "Correo": correo.text,
        "Contraseña": contrasena.text
      });
    } catch (e) {
      print("error.. " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("0xFFBADD73")),
        title: Text('Crear cuenta'),
      ),
      backgroundColor: Color(int.parse("0xFFBADD73")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              child: TextField(
                controller: nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
            ),
            Container(
              width: 250,
              child: TextField(
                controller: correo,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
              ),
            ),
            Container(
              width: 250,
              child: TextField(
                controller: contrasena,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ),
            SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {
                registroUsuario();
                nombre.clear();
                correo.clear();
                contrasena.clear();
              },
              child: Text('Registrarse'),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
