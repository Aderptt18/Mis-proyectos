import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_uts/servicios/manejoImagenes/seleccionarImagen.dart';
import 'package:eventos_uts/servicios/manejoImagenes/subirImagenFirebase.dart';
import 'package:flutter/material.dart'; 

class pantallaPrincpipal_pagina_peticionEvento_estudiante extends StatefulWidget {

  @override
  State<pantallaPrincpipal_pagina_peticionEvento_estudiante> createState() => _pantallaPrincpipal_pagina_peticionEvento_estudianteState();
} 

class _pantallaPrincpipal_pagina_peticionEvento_estudianteState extends State<pantallaPrincpipal_pagina_peticionEvento_estudiante> {
  
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  String url = '';
  File? imagen_a_subir;
  final firebase = FirebaseFirestore.instance;
  registroEvento(String urlImagen) async {
    try {
      await firebase.collection('peticion_eventos').doc().set({
        'Nombre': nombreController.text,
        'Fecha': fechaController.text,
        'Lugar': lugarController.text,
        'Hora': horaController.text,
        'Descripcion': descripcionController.text,
        'Imagen_url': urlImagen,
        'creado': FieldValue.serverTimestamp(), 
      });
    } catch (e) {
      print("error.. " + e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Esto quita la flecha de retroceso
        backgroundColor: Color(int.parse("0xFFBADD73")),
        title: Text(
          'Petición Evento',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(int.parse("0xFFBADD73")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(
                      100), //asigna un tamaño horizontal a la columna 0
                  1: FlexColumnWidth(
                      300), //asigna un tamaño horizontal a la columna 1
                },
                children: [
                  TableRow(children: [
                    Text('Nombre:'),
                    TextField(
                      controller: nombreController,
                      decoration: InputDecoration(
                        hintText: 'Nombre del evento',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Fecha:'),
                    TextField(
                      controller: fechaController,
                      decoration: InputDecoration(
                        hintText: 'dd/mm/aaaa',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Lugar:'),
                    TextField(
                      controller: lugarController,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Hora:'),
                    TextField(
                      controller: horaController,
                      decoration: InputDecoration(
                        hintText: 'hh:mm',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Descripción:'),
                    TextField(
                      controller: descripcionController,
                      decoration: InputDecoration(
                        hintText: 'Opcional',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            imagen_a_subir != null //comprobar que la imagen fue seleccionada
                ? Image.file(imagen_a_subir!)
                : Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: double.infinity,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
            ElevatedButton(
              onPressed: () async {
                final imagen = await getImage();
                setState(() {
                  imagen_a_subir = File(imagen!.path);
                });
              },
              child: Text('Subir imagen'),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                
                onPressed: () async {
                  if (imagen_a_subir == null) {
                    return;
                  } else {
                    await subirImagenEstudiante(imagen_a_subir!, (String url) {
                      setState(() {
                        this.url = url;
                      });
                    }, nombreController);
                  }
                  await registroEvento(url);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('EVENTO HA SIDO CARGADO CON ÉXITO')),
                  );
                  nombreController.clear();
                  fechaController.clear();
                  lugarController.clear();
                  horaController.clear();
                  descripcionController.clear();
                  setState(() {
                    imagen_a_subir = null;
                  });
                },
                child: Text('SUBIR PETICIÓN'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
