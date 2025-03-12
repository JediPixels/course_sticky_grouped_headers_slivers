import 'dart:convert';

class QuotesListModel {
  List<Quote> quotes;

  QuotesListModel({
    required this.quotes,
  });

  static QuotesListModel quotesModelFromJson(String str) =>
      QuotesListModel.fromJson(json.decode(str));
  static String quotesModelToJson(QuotesListModel data) =>
      json.encode(data.toJson());

  factory QuotesListModel.fromJson(Map<String, dynamic> json) =>
      QuotesListModel(
        quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
      };
}

class Quote {
  int id;
  String quote;
  String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        quote: json["quote"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote": quote,
        "author": author,
      };
}

// JSON Sample
/*
{
  "quotes": [
    {
      "id": 1,
      "quote": "Life isn’t about getting and having, it’s about giving and being.",
      "author": "Kevin Kruse"
    },
    {
      "id": 2,
      "quote": "Whatever the mind of man can conceive and believe, it can achieve.",
      "author": "Napoleon Hill"
    }
  ]
}
*/
