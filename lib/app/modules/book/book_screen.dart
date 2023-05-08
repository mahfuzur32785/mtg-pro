import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/modules/book/controller/book_controller.dart';
import 'package:mtgpro/app/modules/book/model/book_model.dart';

class BookStore extends StatelessWidget {
  const BookStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BookController>(
          init: BookController(),
          builder: (controller) {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    sliver: SliverToBoxAdapter(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Field is required*';
                                }
                                return null;
                              },
                              controller: controller.titleController,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Field is required*';
                                }
                                return null;
                              },
                              controller: controller.yearController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  await controller.addBook(Book(
                                      0,
                                      controller.titleController.text,
                                      int.parse(
                                          controller.yearController.text)));
                                  controller.titleController.clear();
                                  controller.yearController.clear();
                                  controller.getAllBooks();
                                }
                              },
                              child: const Text("Save"),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    sliver: SliverToBoxAdapter(
                      child: BookTable(controller, () {
                        controller.getAllBooks();
                      }),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class BookTable extends StatelessWidget {
  final BookController bookController;
  final VoidCallback _refreshList;

  const BookTable(this.bookController, this._refreshList, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
        future: bookController.getAllBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading..'));
          } else {
            return DataTable(
                columns: _createBookTableColumns(),
                rows: _createBookTableRows(snapshot.data ?? []));
          }
        });
  }

  List<DataColumn> _createBookTableColumns() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Book')),
      const DataColumn(label: Text('Action')),
    ];
  }

  List<DataRow> _createBookTableRows(List<Book> books) {
    return books
        .map((book) => DataRow(cells: [
              DataCell(Text('#${book.id}')),
              DataCell(Text('${book.title} (${book.year.toString()})')),
              DataCell(IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await bookController.removeBook(book.id);
                  _refreshList();
                },
              )),
            ]))
        .toList();
  }
}
