import 'package:eventos_uts/servicios/evento.dart';
import 'package:flutter/material.dart';

class EventosProvider with ChangeNotifier {
  List<Evento> _eventosGuardados = [];

  List<Evento> get eventosGuardados => _eventosGuardados;

  void agregarEvento(Evento evento) {
    _eventosGuardados.add(evento);
    notifyListeners();
  }

  void eliminarEvento(Evento evento) {
    _eventosGuardados.remove(evento);
    notifyListeners();
    _eventosGuardados.clear();
  }
}
