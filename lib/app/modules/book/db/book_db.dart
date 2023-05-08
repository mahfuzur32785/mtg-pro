import 'dart:math';

class BookDb {
  List<Map<String, dynamic>> _items = [];
  static final BookDb _bookDb = BookDb._privateConstructor();
  BookDb._privateConstructor();

  factory BookDb(){
    return _bookDb;
  }

  Future<void> insert(Map<String, dynamic> item) async {
    item['id'] = Random().nextInt(1000);
    _items.add(item);
  }

  Future<void> remove(int id) async {
    _items.removeWhere((item) => item['id'] == id);
  }

  Future<void> update(Map<String, dynamic> updatedItem) async {
    int i = _items.indexWhere((item) => item['id'] == updatedItem['id']);
    _items[i] = updatedItem;
  }

  Future<List<Map<String, dynamic>>> list() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _items;
  }

  Future<Map<String, dynamic>?> findOne(int id) async {
    return _items.firstWhere((item) => item['id'] == id);
  }
}