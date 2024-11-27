import 'package:flutter/material.dart';
import '../../models/book.dart';

class BookSearch extends StatefulWidget {
  const BookSearch({super.key});

  @override
  State<BookSearch> createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  String searchText = '';
  List<Book> books = [];
  void searchBooks(String search) {
    setState(() {
      books = [
        Book(title: 'Book1', author: 'Author1', pages: 150),
        Book(title: 'Book2', author: 'Author2', pages: 200),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Book name',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        searchBooks(searchText);
                      },
                      child: const Text('Search'),
                    ),
                  ],
                ),
              ],
            ),
            ListView(
              children: 
                books.map((book) {
                  return ListTile(
                    title: Text(book.title!),
                    subtitle: Text(book.author!),
                    trailing: Text(book.pages.toString()),
                  );
                }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
