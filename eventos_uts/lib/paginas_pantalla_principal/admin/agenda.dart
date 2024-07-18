import 'package:eventos_uts/servicios/provider/agendaAdmin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class pantallaPrincpipal_pagina_agenda_admin extends StatelessWidget {
  // Define un color más claro que el color original
  final Color lighterColor = Color(0xFFCCEBB5); // Color más claro que FFAADD73

  @override
  Widget build(BuildContext context) {
    final eventosGuardados = Provider.of<EventosProvider>(context).eventosGuardados;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Eventos'),
        backgroundColor: Color(int.parse("0xFFBADD73")),// Verde original
      ),
      backgroundColor: Color(int.parse("0xFFBADD73")),
      body: ListView.builder(
        itemCount: eventosGuardados.length,
        itemBuilder: (context, index) {
          final evento = eventosGuardados[index];

          return Card(
            color: lighterColor,
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              title: Text(
                evento.nombre,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      evento.imagenUrl.isNotEmpty
                          ? Image.network(evento.imagenUrl)
                          : Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey,
                              child: Icon(Icons.event, color: Colors.white, size: 50),
                            ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Fecha: ${evento.fecha}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.place),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Lugar: ${evento.lugar}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Hora: ${evento.hora}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.description),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Descripción: ${evento.descripcion}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
