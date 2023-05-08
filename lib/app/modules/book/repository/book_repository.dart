import 'package:mtgpro/app/modules/book/db/book_db.dart';
import 'package:mtgpro/app/modules/book/iRepository/ibook_repository.dart';
import 'package:mtgpro/app/modules/book/model/book_model.dart';

class BookRepository extends IBookRepository {
  final BookDb _bookDb;

  BookRepository(this._bookDb);

  @override
  Future<void> delete(int id) async {
    await _bookDb.remove(id);
  }

  @override
  Future<List<Book>> getAll() async {
    var items = await _bookDb.list();
    return items.map((item) => Book.fromMap(item)).toList();
  }

  @override
  Future<Book?> getOne(int id) async {
    var item = await _bookDb.findOne(id);
    return item != null ? Book.fromMap(item) : null;
  }

  @override
  Future<void> insert(Book book) async {
    await _bookDb.insert(book.toMap());
  }

  @override
  Future<void> update(Book book) async {
    await _bookDb.update(book.toMap());
  }

}