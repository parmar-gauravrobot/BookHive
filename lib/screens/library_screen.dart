import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/books_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/book_form_sheet.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BooksProvider>().loadBooks());
  }

  void _openForm([Book? book]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BookFormSheet(
        initial: book,
        onSubmit: (b) async {
          if (book == null) {
            await context.read<BooksProvider>().addBook(b);
          } else {
            await context.read<BooksProvider>().updateBook(b);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BooksProvider>();
    final books = provider.books;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final value = await showSearch<String?>(
                context: context,
                delegate: _BookSearchDelegate(onQuery: provider.search),
              );
              if (value == null || value.isEmpty) {
                // reset
                await provider.search('');
              }
            },
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(child: Text('No books yet. Tap + to add.'))
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return BookCard(
                  book: book,
                  onTap: () => _openForm(book),
                  onFavorite: () async {
                    await context.read<BooksProvider>().updateBook(
                          book.copyWith(isFavorite: !book.isFavorite),
                        );
                  },
                  onDelete: () async {
                    if (book.id != null) {
                      await context.read<BooksProvider>().deleteBook(book.id!);
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BookSearchDelegate extends SearchDelegate<String?> {
  final Future<void> Function(String) onQuery;
  _BookSearchDelegate({required this.onQuery});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onQuery(query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}


