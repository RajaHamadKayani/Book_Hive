import 'package:bookhive/controllers/book_controller.dart';
import 'package:bookhive/models/book_model.dart';
import 'package:bookhive/views/all_books_view.dart';
import 'package:bookhive/views/widgets/reusable_container.dart';
import 'package:bookhive/views/widgets/reusable_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({super.key});

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  final BookController bookController = Get.put(BookController());
  final _formKey = GlobalKey<FormState>();

  // Focus nodes for the text fields
  final _titleFocusNode = FocusNode();
  final _authorFocusNode = FocusNode();
  final _genreFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow the screen to resize when the keyboard is open
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back(); // Navigate back
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 18,
                                color: Color(0xff1F1C33),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "BOOK HIVE",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Pulp",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          width: 46), // Spacer to align the back button
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  ReusableTextFieldWidget(
                    controller: bookController.textEditingControllerTitle.value,
                    hintText: "Enter Book Title",
                    suffixIcon: const Icon(Icons.title, color: Colors.black),
                    title: 'Book Title',
                    focusNode: _titleFocusNode, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_authorFocusNode);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller:
                        bookController.textEditingControllerAuthor.value,
                    hintText: "Enter Author Name",
                    suffixIcon: const Icon(Icons.person, color: Colors.black),
                    title: 'Author Name',
                    focusNode: _authorFocusNode, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_genreFocusNode);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller: bookController.textEditingControllerGenre.value,
                    hintText: "Enter Genre",
                    suffixIcon:
                        const Icon(Icons.type_specimen, color: Colors.black),
                    title: 'Book Genre',
                    focusNode: _genreFocusNode, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller:
                        bookController.textEditingControllerDescription.value,
                    hintText: "Enter Book Description",
                    suffixIcon:
                        const Icon(Icons.description, color: Colors.black),
                    title: 'Book Description',
                    focusNode: _descriptionFocusNode, // Assign focus node
                    textInputAction: TextInputAction.done, // Close the keyboard
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Obx(
                      () => bookController.isLoading.value
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  String id = const Uuid().v4();
                                  String title = bookController
                                      .textEditingControllerTitle.value.text;
                                  String author = bookController
                                      .textEditingControllerAuthor.value.text;
                                  String genre = bookController
                                      .textEditingControllerGenre.value.text;
                                  String description = bookController
                                      .textEditingControllerDescription
                                      .value
                                      .text;

                                  Book newBook = Book(
                                    id: id,
                                    title: title,
                                    author: author,
                                    genre: genre,
                                    description: description,
                                    createdAt: DateTime.now(),
                                  );

                                  await bookController.addBook(newBook);

                                  // Clear the text fields after successful upload
                                  bookController
                                      .textEditingControllerTitle.value
                                      .clear();
                                  bookController
                                      .textEditingControllerAuthor.value
                                      .clear();
                                  bookController
                                      .textEditingControllerGenre.value
                                      .clear();
                                  bookController
                                      .textEditingControllerDescription.value
                                      .clear();
                                  await bookController.addBook(newBook);
                                  bookController.fetchBooks(); // Reload books
                                  Get.off(() => const AllBooksView());
                                }
                              },
                              child: ReusableContainer(
                                borderRadius: BorderRadius.circular(50),
                                color: 0xff000000,
                                title: "Upload Book",
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
