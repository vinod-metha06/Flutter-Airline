import 'package:flutter/material.dart';
import 'package:airlines/Model/photo.dart';
import 'package:provider/provider.dart';
import '../api/service.dart';

class Counter extends ChangeNotifier {
  final _service = Api();
  bool loading = false;
  List<Photos> _photos = [];

  get photos => _photos;
  late Photos? _al = Photos();
  get al => _al;

  Future<void> getAllPhotos() async {
    loading = true;
    notifyListeners();

    _photos = await _service.getAll();

    loading = false;
    notifyListeners();
  }

  Future<void> getAl(id) async {
    _al = await _service.fetchAlbum(id);

    notifyListeners();
  }

  // int _count = 0;
  // get count => _count;

  // void increment() {
  //   _count += 1;
  //   notifyListeners();
  //}

}
