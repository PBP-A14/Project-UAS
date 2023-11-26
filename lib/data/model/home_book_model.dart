import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    model: modelValues.map[json["model"]] ?? Model.HOME_BOOK,
    pk: json["pk"] ?? 0,
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": modelValues.reverse[model],
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String title;
  Description description;
  String authors;
  String isbn;
  int numPages;
  String publisher;
  int ratingCount;
  double rating;

  Fields({
    required this.title,
    required this.description,
    required this.authors,
    required this.isbn,
    required this.numPages,
    required this.publisher,
    required this.ratingCount,
    required this.rating,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    title: json["title"],
    description: descriptionValues.map[json["description"]]!,
    authors: json["authors"],
    isbn: json["isbn"],
    numPages: json["num_pages"],
    publisher: json["publisher"],
    ratingCount: json["rating_count"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": descriptionValues.reverse[description],
    "authors": authors,
    "isbn": isbn,
    "num_pages": numPages,
    "publisher": publisher,
    "rating_count": ratingCount,
    "rating": rating,
  };
}

enum Description {
  EMPTY
}

final descriptionValues = EnumValues({
  "-": Description.EMPTY
});

enum Model {
  HOME_BOOK
}

final modelValues = EnumValues({
  "home.book": Model.HOME_BOOK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
