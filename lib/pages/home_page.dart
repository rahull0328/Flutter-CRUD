import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Firestore service
  final FireStoreService fireStoreService = FireStoreService();

  // Text controller
  final TextEditingController textEditingController = TextEditingController();

  // Open note dialog
  void openNoteBox({String? docID, String? currentNote}) {
    textEditingController.text = currentNote ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textEditingController),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                fireStoreService.addNote(textEditingController.text, context);
              } else {
                fireStoreService.updateNote(docID, textEditingController.text, context);
              }
              textEditingController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Logout user
  void logout() {
    FirebaseAuth.instance.signOut();
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
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(),
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = notesList[index];
                String docID = documentSnapshot.id;
                Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
                String noteText = data['note'];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      title: Text(noteText),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            onPressed: () => openNoteBox(docID: docID, currentNote: noteText),
                            icon: const Icon(Icons.edit, color: Colors.green),
                          ),
                          IconButton(
                            onPressed: () => fireStoreService.deleteNote(docID, context),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No Notes..."));
          }
        },
      ),
    );
  }
}
