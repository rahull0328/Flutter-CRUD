import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // get all notes
  final CollectionReference notes =
    FirebaseFirestore.instance.collection('notes');
  //CREATE: adding a new note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }
  //READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }

  //UPDATE: updating a note

  //DELETE: deleting a note
}