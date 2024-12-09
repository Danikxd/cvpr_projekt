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
  List<String> favourites = [];


  @override
  void initState(){
    super.initState();
     Map<String, dynamic> bookdata = {
      "kind": "books#volume",
      "id": "Gi-2DwAAQBAJ",
      "etag": "SRPXr2aNsIo",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/Gi-2DwAAQBAJ",
      "volumeInfo": {
        "title": "Deník malého poseroutky 1",
        "authors": ["Jeff Kinney"],
        "publisher": "Cooboo",
        "publishedDate": "2018-01-01",
        "description":
            "Greg Heffley není žádný béčko! Když je vám tak jedenáct, může to být fakt opruz. A nikdo to neví líp než Greg Heffley, protože se najednou ocitl na škole, kde malí poseroutkové, jako je on, naráží každý den na chodbách do kluků, kteří jsou větší, silnější a holit by se mohli dvakrát denně. Deník malého poseroutky není jen tak obyčejný deníček. Greg tenhle sešit dostal od mámy. A to přesto, že deníky jsou přece jenom pro holky! Takže si nemyslete, že to bude nějaké milý deníčku tohle a milý deníčku támhleto.",
        "industryIdentifiers": [
          {"type": "ISBN_13", "identifier": "9788075446503"},
          {"type": "ISBN_10", "identifier": "807544650X"}
        ],
        "readingModes": {"text": false, "image": true},
        "pageCount": 227,
        "printType": "BOOK",
        "categories": ["Juvenile Fiction"],
        "averageRating": 5,
        "ratingsCount": 1,
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": true,
        "contentVersion": "2.738.27.0.preview.1",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "imageLinks": {
          "smallThumbnail":
              "http://books.google.com/books/content?id=Gi-2DwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
          "thumbnail":
              "http://books.google.com/books/content?id=Gi-2DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
        },
        "language": "cs",
        "previewLink":
            "http://books.google.cz/books?id=Gi-2DwAAQBAJ&printsec=frontcover&dq=Diary+Of+Wimpy+Kid+1&hl=&cd=1&source=gbs_api",
        "infoLink":
            "https://play.google.com/store/books/details?id=Gi-2DwAAQBAJ&source=gbs_api",
        "canonicalVolumeLink":
            "https://play.google.com/store/books/details?id=Gi-2DwAAQBAJ"
      },
      "saleInfo": {
        "country": "CZ",
        "saleability": "FOR_SALE",
        "isEbook": true,
        "listPrice": {"amount": 179, "currencyCode": "CZK"},
        "retailPrice": {"amount": 161.1, "currencyCode": "CZK"},
        "buyLink":
            "https://play.google.com/store/books/details?id=Gi-2DwAAQBAJ&rdid=book-Gi-2DwAAQBAJ&rdot=1&source=gbs_api",
        "offers": [
          {
            "finskyOfferType": 1,
            "listPrice": {"amountInMicros": 179000000, "currencyCode": "CZK"},
            "retailPrice": {"amountInMicros": 161100000, "currencyCode": "CZK"}
          }
        ]
      },
      "accessInfo": {
        "country": "CZ",
        "viewability": "PARTIAL",
        "embeddable": true,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {"isAvailable": false},
        "pdf": {
          "isAvailable": true,
          "acsTokenLink":
              "http://books.google.cz/books/download/Den%C3%ADk_mal%C3%A9ho_poseroutky_1-sample-pdf.acsm?id=Gi-2DwAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "webReaderLink":
            "http://play.google.com/books/reader?id=Gi-2DwAAQBAJ&hl=&source=gbs_api",
        "accessViewStatus": "SAMPLE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {"textSnippet": "Greg Heffley není žádný béčko!"}
    };

    Book book = Book.fromJson(bookdata);
    books.add(book);
  }
  void searchBooks(String search) {

  }

  void addToFavourites(Book book) {
    if(book.id == null) {
      return;
    }

    String bookId = book.id!;

    setState(() {
      book.favourite = !book.favourite;
      if (book.favourite) {
        favourites.add(bookId);
      } else {
        if(favourites.contains(book.id)){
          favourites.remove(bookId);
        }
      }
      print('favourite: ${book.favourite}, $favourites');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        searchBooks(searchText);
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Book name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    searchBooks(searchText);
                  },
                  child: const Text('Search'),
                ), 
              ],
            ),
            Expanded(
              child: ListView(
                children: books.map((book) {
                  if(book.title == null || !book.title!.toLowerCase().contains(searchText.toLowerCase()) && searchText != "") return Container();
                  return ListTile(
                    leading: Image.network(
                      book.smallThumbnail ?? "",
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(book.title ?? ""),
                    subtitle: Row(
                      children: [
                        Text(book.authors?[0] ?? ""),
                        IconButton(
                            onPressed: () {
                              addToFavourites(book);
                            },
                            icon: Icon(book.favourite
                                ? Icons.star
                                : Icons.star_border))
                      ],
                    ),
                    trailing: Text('${book.pageCount.toString()} pages'),
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
