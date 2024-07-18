import 'package:eventos_uts/servicios/provider/agendaAdmin.dart';
import 'package:eventos_uts/servicios/provider/agenddaEstudiante.dart';
import 'package:eventos_uts/servicios/provider/datosAdmin.dart';
import 'package:eventos_uts/servicios/provider/datosEstudiante.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa firebase_core
import 'package:provider/provider.dart';

import 'pantalla_ingreso.dart'; //importacion de la pantalla de ingreso

void main() async {
  //función principal de la app
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //por si no se conecta que no se rompa la app
    await Firebase.initializeApp(); // Inicializa Firebase
  } catch (e) {
    print('Error al inicializar Firebase: ' + e.toString());
  } // Inicializa Firebase
  runApp(
    MultiProvider(
      // Utiliza MultiProvider para envolver múltiples instancias de Provider
      providers: [
        ChangeNotifierProvider(create: (context) => datosAdmin()),
        ChangeNotifierProvider(create: (context) => datosEstudiante()),
        ChangeNotifierProvider(create: (context) => EventosProvider()),
        ChangeNotifierProvider(create: (context) => EventosProviderEstu()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //sirve para quitar la etiqueta de debug
      title: 'Eventos UTS', //titulo
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(), // Mostramos el SplashScreen primero
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula una carga asincrónica (puedes agregar aquí la lógica de carga necesaria)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PantallaIngreso()), // Navega a la pantalla de ingreso después de 3 segundos
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aquí puedes personalizar tu SplashScreen
    return Scaffold(
      backgroundColor: Colors.green, // Color de fondo
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250, // Ancho del contenedor
            height: 250, // Altura del contenedor
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo.png'), // Ruta de la imagen
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
              ),
            ),
          )
        ],
      )), // Ruta de la imagen de SplashScreen
    );
  }
}
