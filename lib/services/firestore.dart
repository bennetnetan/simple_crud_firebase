import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // Get the collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // CREATE: add a new note
  Future<void> addNote(String note) async {
    await notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
      });
  }
      

  // READ: get the notes from database

  // UPDATE: update the notes given a note id

  // DELETE: deleting notes from a given note id

}