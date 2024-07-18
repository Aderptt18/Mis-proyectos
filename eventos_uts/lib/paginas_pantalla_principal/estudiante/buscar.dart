import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class pantallaPrincpipal_pagina_buscar_estudiante extends StatefulWidget {
  @override
  State<pantallaPrincpipal_pagina_buscar_estudiante> createState() =>
      _pantallaPrincpipal_pagina_buscar_estudianteState();
}

class _pantallaPrincpipal_pagina_buscar_estudianteState
    extends State<pantallaPrincpipal_pagina_buscar_estudiante> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAADD73),
        automaticallyImplyLeading:
                false,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar eventos por nombre...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          onChanged: (query) {
            setState(() {
              searchQuery = query;
            });
          },
        ),
      ),
      backgroundColor: Color(0xFFCCEBB5),
      body: (searchQuery.isEmpty)
          ? Center(child: Text('Ingrese un nombre para buscar eventos'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('eventos')
                  .where('Nombre', isGreaterThanOrEqualTo: searchQuery)
                  .where('Nombre', isLessThanOrEqualTo: searchQuery + '\uf8ff')
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
                      color: Color(0xFFCCEBB5),
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
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
                    );
                  },
                );
              },
            ),
    );
  }
}
