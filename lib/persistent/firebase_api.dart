import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvpr_projekt/models/book.dart';

class FirebaseApi {
  FirebaseApi._();

  static final FirebaseApi instance = FirebaseApi._();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Book> books = [];
  List<String> favouriteIds = [];
  List<String> readIds = [];
  List<String> googleFavoriteIds = [];
  List<String> googleReadIds = [];

  void filterNonFirebaseIds() {
    googleFavoriteIds = [];
    googleReadIds = [];

    for (var id in favouriteIds) {
      if (int.tryParse(id) == null) {
        googleFavoriteIds.add(id);
      }
    }

    for (var id in readIds) {
      if (int.tryParse(id) == null) {
        googleReadIds.add(id);
      }
    }
  }

  Future<void> modifyFavourites(String id) async {
    if (favouriteIds.contains(id)) {
      await removeFavourite(id);
    } else {
      await addFavourite(id);
    }
    await fetch();
  }

  Future<void> modifyRead(String id) async {
    if (readIds.contains(id)) {
      await removeRead(id);
    } else {
      await addRead(id);
    }
    await fetch();
  }

  Future<void> changeFavouriteInDb() async {
    dynamic favourites = await fetchFavorites();

    for (var book in books) {
      if (book.favourite && !favourites.contains(book.id)) {
        await addFavourite(book.id!);
      }
      if (book.favourite && favourites.contains(book.id)) {
        return;
      }
      {
        await removeFavourite(book.id!);
      }
    }
  }

  Future<void> changeReadInDb() async {
    dynamic read = await fetchRead();

    for (var book in books) {
      if (book.read && !read.contains(book.id)) {
        await addRead(book.id!);
      }
      if (book.read && read.contains(book.id)) {
        return;
      }
      {
        await removeRead(book.id!);
      }
    }
  }

  Future<List<Book>> getBooks() async {
    List<Book> books = [];
    var querySnapshot = await _db.collection('books').get();
    for (var doc in querySnapshot.docs) {
      books.add(Book.fromFirebase(doc.data(), doc.id));
    }
    return books;
  }

  Future<List<String>> fetchFavorites() async {
    List<String> favouriteIds = [];
    var querySnapshot = await _db.collection('favourites').get();
    for (var doc in querySnapshot.docs) {
      favouriteIds.add(doc.id);
    }
    return favouriteIds;
  }

  Future<List<String>> fetchRead() async {
    List<String> readIds = [];
    var querySnapshot = await _db.collection('read').get();
    for (var doc in querySnapshot.docs) {
      readIds.add(doc.id);
    }
    return readIds;
  }

  Future<void> getRead() async {
    readIds = await fetchRead();
  }

  Future<void> processRead() async {
    await getRead();
    for (var book in books) {
      if (readIds.contains(book.id)) {
        book.read = true;
      }
    }
  }

  Future<void> removeRead(String id) async {
    await _db.collection('read').doc(id).delete();
  }

  Future<void> addRead(String id) async {
    await _db.collection('read').doc(id).set({});
  }

  Future<void> getFavourites() async {
    favouriteIds = await fetchFavorites();
  }

  Future<void> processFavourites() async {
    await getFavourites();
    for (var book in books) {
      if (favouriteIds.contains(book.id)) {
        book.favourite = true;
      }
    }
  }

  Future<void> removeFavourite(String id) async {
    await _db.collection('favourites').doc(id).delete();
  }

  Future<void> addFavourite(String id) async {
    await _db.collection('favourites').doc(id).set({});
  }

  Future<void> fetch() async {
    books = await getBooks();
    await processFavourites();
    await processRead();
    filterNonFirebaseIds();
  }

  Future<void> createBook(
      String title,
      String author,
      int? pageCount,
      String? description,
      String? thumbnail,
      String publisher,
      String publishedDate) async {
    await _db.collection('books').add({
      'title': title,
      'author': author,
      'pageCount': pageCount,
      'description': description,
      'thumbnail': thumbnail,
      'publisher': publisher,
      'publishedDate': publishedDate,
    });
    fetch();
  }
}
