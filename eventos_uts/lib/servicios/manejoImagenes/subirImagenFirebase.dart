import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> subirImagen(File image,  Function(String) updateUrl,TextEditingController controller) async {
  final String nameFile = controller.text;
  final Reference ref = storage.ref().child("Eventos").child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  updateUrl(url);
  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}

Future<bool> subirImagenEstudiante(File image,  Function(String) updateUrl,TextEditingController controller) async {
  final String nameFile = controller.text;
  final Reference ref = storage.ref().child("Peticiones").child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  updateUrl(url);
  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
