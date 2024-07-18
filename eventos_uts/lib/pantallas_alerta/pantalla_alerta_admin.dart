import 'package:eventos_uts/pantalla_login_admin.dart';
import 'package:flutter/material.dart';

class AlertaAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("0xFFBADD73")),
        title: Text('NO REGISTRADO'),
      ),
      backgroundColor: Color(int.parse("0xFFBADD73")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('CORREO O CONTRASEÑA INCORRECTOS'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PantallaLoginAdmin()),
                  );
            },
            child: Text('Volver'))
        ],
      )),
    );
  }
}