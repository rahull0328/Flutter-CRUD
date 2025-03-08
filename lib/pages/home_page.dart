import 'package:cloud_firestore/cloud_firestore.dart';
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

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textEditingController),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //adding the note.
                  if (docID == null) {
                    fireStoreService.addNote(textEditingController.text);
                  } else {
                    fireStoreService.updateNote(docID, textEditingController.text);
                  }

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
        title: const Text(
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
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context, snapshot) {
          //if notes are present
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            
            //displaying data in the list
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  //getting each individual doc
                  DocumentSnapshot documentSnapshot = notesList[index];
                  String docID = documentSnapshot.id;

                  //get note from each doc
                  Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  //display as a list tile
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //update button
                        IconButton(
                          onPressed: () => openNoteBox(docID: docID),
                          icon: Icon(Icons.edit, color: Colors.green),
                        ),
                        //delete button
                        IconButton(
                          onPressed: () => fireStoreService.deleteNote(docID),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
            );
          } else {
            return const Text("No Notes....");
          }
        },
      ),
    );
  }
}
