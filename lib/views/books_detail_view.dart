import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final String bookName;
  final String authorName;
  final String genre;
  final String description;
  final DateTime dateTime;

  const BookDetailsPage({
    super.key,
    required this.bookName,
    required this.authorName,
    required this.genre,
    required this.description,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Details",
          style: TextStyle(
            fontFamily: "Pulp",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff3CBBB1),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Cover
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Text(
                  bookName[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3CBBB1),
                  ),
                ),
              ),
            ),

            // Book Details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Name
                  Text(
                    bookName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pulp",
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Author Name
                  Text(
                    "Author: $authorName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Pulp",
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Genre
                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        size: 20,
                        color: Color(0xff3CBBB1),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Genre: $genre",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Pulp",
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Description
                  const Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pulp",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Pulp",
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Added Date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Color(0xff3CBBB1),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Added On: ${dateTime.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Pulp",
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3CBBB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Pulp",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffEE4266),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Add your delete or favorite functionality here
                      },
                      child: const Text(
                        "Favorite",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Pulp",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
