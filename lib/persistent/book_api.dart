import 'package:cvpr_projekt/models/book.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class BookApi {
  BookApi._();

  String _APIKEY = '';

  static final BookApi instance = BookApi._();
  void setKey(String key) {
    _APIKEY = key;
  }

  Future<List<Book>> getBooks(String? query) async {
    List<Book> books = [];
    var uri =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': query, 'key': _APIKEY});
    var resp = await http.get(uri);

    if (resp.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(resp.body) as Map<String, dynamic>;
      for (var item in jsonResponse['items']) {
        print(item['volumeInfo']['publishedDate']);
        books.add(Book.fromJson(item));

        print('Title: ${item['volumeInfo']['title']}');
      }
    } else {
      throw Exception('Failed to load books (${resp.statusCode})');
    }
    return books;
  }

  Future<Book> getBook(String id) async {
    var uri = Uri.https('www.googleapis.com', '/books/v1/volumes/$id', {'key': _APIKEY});
    var resp = await http.get(uri);

    if (resp.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(resp.body) as Map<String, dynamic>;
      return Book.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load book (${resp.statusCode})');
    }
  }
}
