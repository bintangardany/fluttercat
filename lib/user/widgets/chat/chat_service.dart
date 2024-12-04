import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      DocumentSnapshot senderDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      DocumentSnapshot receiverDoc =
          await _firestore.collection('users').doc(receiverId).get();

      String senderRole = senderDoc['role'] ?? '';
      String receiverRole = receiverDoc['role'] ?? '';

      if (senderRole != 'user' || receiverRole != 'admin') {
        throw Exception('Unauthorized chat: Only users can chat with admins');
      }

      await _firestore.collection('chats').add({
        'senderId': currentUser.uid,
        'senderEmail': currentUser.email,
        'receiverId': receiverId,
        'message': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Chat Service Error: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getChatStream(
      String userId, String adminId) {
    return Stream.fromIterable([
      _firestore
          .collection('chats')
          .where('senderId', isEqualTo: userId)
          .where('receiverId', isEqualTo: adminId)
          .snapshots(),
      _firestore
          .collection('chats')
          .where('senderId', isEqualTo: adminId)
          .where('receiverId', isEqualTo: userId)
          .snapshots(),
    ]).asyncExpand((snapshotStream) => snapshotStream.map((snapshot) {
          return snapshot.docs
              .map((doc) => {
                    'id': doc.id,
                    'message': doc['message'] ?? '',
                    'senderId': doc['senderId'] ?? '',
                    'receiverId': doc['receiverId'] ?? '',
                    'timestamp': doc['timestamp'] ?? '',
                  })
              .toList();
        }));
  }

  Future<String?> getAdminId() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'admin')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first.id;
    } catch (e) {
      print('Error fetching admin ID: $e');
      return null;
    }
  }
}
