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
  Stream<QuerySnapshot> getNotesStream() {
      final notesStream = notes.orderBy('timestamp', descending: true).snapshots();

      return notesStream;
  }

  // UPDATE: update the notes given a note id
  Future<void> updateNotes(String docId, String newNote){
    return notes.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: deleting notes from a given note id
  Future<void> deleteNotes(String docId) {
    return notes.doc(docId).delete();
  }

}