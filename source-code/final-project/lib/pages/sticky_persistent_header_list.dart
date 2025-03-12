import 'package:flutter/material.dart';
import 'package:quotes/widgets/quotes_by_author.dart';
import 'package:quotes/widgets/sticky_header_delegate.dart';
import 'package:quotes/models/quotes_model.dart';
import 'package:quotes/services/quotes_service.dart';

class StickyPersistentHeaderList extends StatefulWidget {
  const StickyPersistentHeaderList({super.key});

  @override
  State<StickyPersistentHeaderList> createState() =>
      _StickyPersistentHeaderListState();
}

class _StickyPersistentHeaderListState
    extends State<StickyPersistentHeaderList> {
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
        title: const Text('Quotes by Persistent Header'),
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
                      SliverPersistentHeader(
                        delegate: StickyHeaderDelegate(
                          author: authorAndQuotes.key,
                        ),
                        pinned: true,
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
