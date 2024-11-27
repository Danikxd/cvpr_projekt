import 'package:flutter/material.dart';
import 'package:cvpr_projekt/models/book.dart';

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
        Book(title: 'Book1', author: 'Author1', pages: 150, img: 'https://www.w3schools.com/images/img_girl.jpg'),
        Book(title: 'Book2', author: 'Author2', pages: 200, img: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fdictionary.cambridge.org%2Fdictionary%2Fenglish%2Fbook&psig=AOvVaw1UMU7yMdXABJr1GwUL3H5f&ust=1732786471664000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIDUiuOa_IkDFQAAAAAdAAAAABAE'),
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
                Expanded(
                  child: TextField(
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
            Expanded(
              child: ListView(
                children: books.map((book) {
                  return ListTile(
                    leading: Image.network(book.img ?? ""),
                    title: Text(book.title ?? ""),
                    subtitle: Text(book.author ?? ""),
                    trailing: Text(book.pages.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
