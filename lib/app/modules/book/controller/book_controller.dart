import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/book/repository/book_repository.dart';

import '../db/book_db.dart';
import '../model/book_model.dart';

class BookController extends GetxController {
  var isLoading = false.obs;
  BookRepository bookRepository = BookRepository(BookDb());

  final formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var yearController = TextEditingController();

  Future<List<Book>> getAllBooks() {
    return bookRepository.getAll();
  }

  Future<void> addBook(Book book) {
    return bookRepository.insert(book);
  }

  Future<void> removeBook(int id) {
    return bookRepository.delete(id);
  }
}