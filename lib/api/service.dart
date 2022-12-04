import 'package:airlines/Model/photo.dart';
import 'package:http/http.dart' as http;
import '../api/service.dart';
import 'dart:convert';

class Api {
  Future<List<Photos>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/photos';

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      print(json);

      final photos = json.map((e) {
        return Photos(
          albumId: e['albumId'],
          id: e['id'],
          title: e['title'],
          url: e['url'],
        );
      }).toList();
      print(photos[0]);

      return photos;
    }
    return [];
  }

  Future<Photos> fetchAlbum(var id) async {
    print(id + 'jnhnjhnjn');

    final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Photos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
