import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user ID
  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  // Helper method for input validation
  bool _isValidInput(String input) {
    return input.isNotEmpty && input.length <= 500;
  }

  // CREATE: Add a new note
  Future<void> addNote(String note, BuildContext context) async {
    if (!_isValidInput(note)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid input!")));
      return;
    }

    await _firestore.collection('users').doc(userId).collection('notes').add({
      'note': note.trim(),
      'timestamp': Timestamp.now(),
    });
  }

  // READ: Stream notes for the current user
  Stream<QuerySnapshot> getNotesStream() {
    return _firestore.collection('users').doc(userId).collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // UPDATE: Update an existing note
  Future<void> updateNote(String docID, String newNote, BuildContext context) async {
    if (!_isValidInput(newNote)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid input!")));
      return;
    }

    await _firestore.collection('users').doc(userId).collection('notes').doc(docID).update({
      'note': newNote.trim(),
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: Delete a note
  Future<void> deleteNote(String docID, BuildContext context) async {
    await _firestore.collection('users').doc(userId).collection('notes').doc(docID).delete();
  }
}
