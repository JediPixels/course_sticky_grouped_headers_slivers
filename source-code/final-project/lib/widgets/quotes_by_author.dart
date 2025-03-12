import 'package:flutter/material.dart';
import 'package:quotes/models/quotes_model.dart';

class QuotesByAuthor extends StatelessWidget {
  const QuotesByAuthor({
    super.key,
    required this.author,
    required this.quotes,
  });

  final String author;
  final List<Quote> quotes;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (final quote in quotes)
            ListTile(
              contentPadding: const EdgeInsets.all(24.0),
              isThreeLine: true,
              leading: const Icon(Icons.chat_bubble),
              iconColor: Colors.grey,
              title: Text(
                quote.quote,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: const SizedBox(),
            ),
        ],
      ),
    );
  }
}
