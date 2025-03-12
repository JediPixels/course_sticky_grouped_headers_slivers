import 'package:flutter/material.dart';
import 'package:quotes/models/quotes_model.dart';
import 'package:quotes/services/quotes_service.dart';
import 'package:quotes/widgets/quotes_by_author.dart';

class StickyAppBarList extends StatefulWidget {
  const StickyAppBarList({super.key});

  @override
  State<StickyAppBarList> createState() => _StickyAppBarListState();
}

class _StickyAppBarListState extends State<StickyAppBarList> {
  late Future<List<Quote>> _quotesList;

  @override
  void initState() {
    super.initState();
    _quotesList = QuotesService.getQuotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes by AppBar'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Quote>>(
          initialData: const [],
          future: _quotesList,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Quote>> snapshot,
          ) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            List<Quote> quotesList = snapshot.requireData;
            final groupByAuthorMap = quotesList.groupByAuthorMap();

            return CustomScrollView(
              slivers: [
                for (final authorAndQuotes in groupByAuthorMap.entries)
                  SliverMainAxisGroup(
                    slivers: [
                      SliverAppBar(
                        title: Text(
                          authorAndQuotes.key,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        pinned: true,
                        forceElevated: true,
                        shadowColor: Colors.black,
                        centerTitle: false,
                      ),
                      QuotesByAuthor(
                        author: authorAndQuotes.key,
                        quotes: authorAndQuotes.value,
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
