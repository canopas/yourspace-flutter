import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreService(firestore);
});

class FirestoreService {
  final FirebaseFirestore db;

  FirestoreService(this.db);

  int readCount = 0;
  int writeCount = 0;

  Future<DocumentSnapshot<Object?>> getDocument(
      DocumentReference<Object?> docRef) async {
    final doc = await docRef.get();
    await _tracker(1, true);
    return doc;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getQuerySnapshot(
      Query<Map<String, dynamic>> query) async {
    final snapshot = await query.get();
    final readCount = snapshot.docs.length;
    await _tracker(readCount, true);
    return snapshot;
  }

  Future<void> setDocument(
      DocumentReference<Object?> docRef, Map<String, dynamic> data) async {
    await docRef.set(data);
    await _tracker(1, false);
  }

  Future<void> updateDocument(DocumentReference<Map<String, dynamic>> docRef,
      Map<String, dynamic> data) async {
    await docRef.update(data);
    await _tracker(1, false);
  }

  Future<void> _tracker(int count, bool isRead) async {
    if (isRead) {
      readCount += count;
    } else {
      writeCount += count;
    }
    print('XXX usage: read $readCount, write $writeCount');
  }
}
