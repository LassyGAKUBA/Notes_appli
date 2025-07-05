import 'package:cloud_firestore/cloud_firestore.dart';
import 'notes.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(Note note) async {
    await _firestore.collection('notes').doc(note.id).set(note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await _firestore.collection('notes').doc(note.id).update(note.toJson());
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }

  Stream<List<Note>> getNotes() {
    return _firestore.collection('notes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromJson(doc.data());
      }).toList();
    });
  }
}