//pantalla de inicio donde se muestran los eventos

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_uts/paginas_pantalla_principal/estudiante/peticionEvento.dart';
import 'package:eventos_uts/servicios/evento.dart';
import 'package:eventos_uts/servicios/provider/agenddaEstudiante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class pantallaPrincpipal_pagina_inicio_estudiante extends StatefulWidget {
  @override
  State<pantallaPrincpipal_pagina_inicio_estudiante> createState() => _pantallaPrincpipal_pagina_inicio_estudianteState();
}

class _pantallaPrincpipal_pagina_inicio_estudianteState extends State<pantallaPrincpipal_pagina_inicio_estudiante> {
  final Color lighterColor = Color(0xFFCCEBB5); // Color más claro que 0xFFAADD73

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAADD73),
        automaticallyImplyLeading: false, // Esto quita la flecha de retroceso
        title: Text(
          'Eventos',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pantallaPrincpipal_pagina_peticionEvento_estudiante(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFAADD73),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('eventos')
            .orderBy('creado', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay eventos disponibles'));
          }
          final eventos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              final evento = eventos[index];
              return Card(
                color: lighterColor,
                margin: EdgeInsets.all(10.0),
                child: ExpansionTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        leading: evento['Imagen_url'] != null
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(evento['Imagen_url']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey,
                                child: Icon(Icons.event, color: Colors.blue, size: 50),
                              ),
                        title: Text(
                          evento['Nombre'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${evento['Fecha']}'),
                            Text('Lugar: ${evento['Lugar']}'),
                            Text('Hora: ${evento['Hora']}'),
                          ],
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.event_available),
                            onPressed: () {
                              final eventoGuardado = Evento(
                                nombre: evento['Nombre'],
                                fecha: evento['Fecha'],
                                lugar: evento['Lugar'],
                                hora: evento['Hora'],
                                descripcion: evento['Descripcion'] ?? 'No hay descripción disponible',
                                imagenUrl: evento['Imagen_url'] ?? '',
                              );
                              Provider.of<EventosProviderEstu>(context, listen: false)
                                  .agregarEvento(eventoGuardado);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Evento guardado en la agenda: ${evento['Nombre']}')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(evento['Descripcion'] ?? 'No hay descripción disponible'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
