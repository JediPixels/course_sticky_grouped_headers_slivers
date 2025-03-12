import 'package:flutter/services.dart';
import 'package:quotes/models/quotes_model.dart';

class QuotesService {
  static Future<List<Quote>> getQuotesList() async {
    final quotesListJsonFile =
        await rootBundle.loadString('assets/data/quotes.json');

    final quotesListJson =
        QuotesListModel.quotesModelFromJson(quotesListJsonFile).quotes;

    quotesListJson.sort((a, b) => a.author.compareTo(b.author));
    return quotesListJson;
  }
}

extension GroupByAuthorMap on List<Quote> {
  Map<String, List<Quote>> groupByAuthorMap() {
    final groupByAuthorMapList = <String, List<Quote>>{};

    forEach((quote) {
      (groupByAuthorMapList[quote.author] ??= []).add(quote);
    });
    return groupByAuthorMapList;
  }
}

/// Alternative ways to group data
// (groupByAuthorMapList[quote.author] ??= []).add(quote);

// groupByAuthorMapList[quote.author] =
//     (groupByAuthorMapList[quote.author] ?? [])..add(quote);

// groupByAuthorMapList.putIfAbsent(quote.author, () => []).add(quote);

// if (groupByAuthorMapList[quote.author] != null) {
//   groupByAuthorMapList[quote.author] =
//       ((groupByAuthorMapList[quote.author])?..add(quote))!;
// } else {
//   groupByAuthorMapList[quote.author] = [quote];
// }
