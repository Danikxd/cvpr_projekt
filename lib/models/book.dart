class Book {
  String? title;
  String? id;
  int? pageCount;
  String? thumbnail;
  String? smallThumbnail;
  List<String>? authors;
  String? publisher;
  String? description;
  int? avgRating;
  DateTime? publishedDate;
  bool favourite = false;

  Book({this.title, this.authors, this.pageCount, this.thumbnail, this.publisher, this.description, this.avgRating, this.id});

  Book.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    title = json['volumeInfo']['title'],
    pageCount = json['volumeInfo']['pageCount'],
    thumbnail = json['volumeInfo']['imageLinks']['thumbnail'],
    smallThumbnail = json['volumeInfo']['imageLinks']['smallThumbnail'],
    authors = json['volumeInfo']['authors'],
    publisher = json['volumeInfo']['publisher'],
    description = json['volumeInfo']['description'],
    avgRating = json['volumeInfo']['averageRating'],
    publishedDate = DateTime.parse(json['volumeInfo']['publishedDate']);
}