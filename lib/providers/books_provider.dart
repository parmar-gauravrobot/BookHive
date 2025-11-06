import 'package:flutter/foundation.dart';

import '../models/book.dart';
import '../services/db_service.dart';

class BooksProvider extends ChangeNotifier {
  final DbService _db = DbService.instance;
  List<Book> _books = [];
  String _searchQuery = '';

  List<Book> get books => _books;
  String get searchQuery => _searchQuery;

  Future<void> loadBooks() async {
    _books = await _db.getAllBooks();
    notifyListeners();
  }

  Future<void> search(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      await loadBooks();
      return;
    }
    _books = await _db.searchBooks(query);
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await _db.insertBook(book);
    await loadBooks();
  }

  Future<void> updateBook(Book book) async {
    await _db.updateBook(book);
    await loadBooks();
  }

  Future<void> deleteBook(int id) async {
    await _db.deleteBook(id);
    await loadBooks();
  }

  Future<List<Book>> getReading() => _db.getByStatus('reading');
  Future<List<Book>> getRead() => _db.getByStatus('read');
  Future<List<Book>> getToRead() => _db.getByStatus('to_read');
  Future<List<Book>> getFavorites() => _db.getFavorites();
}


