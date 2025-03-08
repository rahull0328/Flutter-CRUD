import 'package:crud/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //firestore
  final FireStoreService fireStoreService = FireStoreService();

  //text controller
  final TextEditingController textEditingController = TextEditingController();

  void openNoteBox() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textEditingController),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //adding the note.
                  fireStoreService.addNote(textEditingController.text);

                  // clear the text controller
                  textEditingController.clear();

                  //closing the alertBox
                  Navigator.pop(context);
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteNest",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
