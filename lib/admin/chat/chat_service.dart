import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send message with comprehensive validation for all roles
  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Validate message length
      if (message.trim().isEmpty || message.length > 500) {
        throw Exception('Invalid message length');
      }

      // Fetch sender and receiver roles
      DocumentSnapshot senderDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      
      DocumentSnapshot receiverDoc = await _firestore
          .collection('users')
          .doc(receiverId)
          .get();

      String senderRole = senderDoc['role'] ?? '';
      String receiverRole = receiverDoc['role'] ?? '';

      // Allow chat between all roles with admin
      if (receiverRole != 'admin' && senderRole != 'admin') {
        throw Exception('Unauthorized chat access');
      }

      // Add message to Firestore
      await _firestore.collection('chats').add({
        'senderId': currentUser.uid,
        'senderEmail': currentUser.email,
        'senderRole': senderRole,
        'receiverId': receiverId,
        'message': message.trim(),
        'isRead': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Chat Service Error: $e');
      rethrow;
    }
  }

  // Get comprehensive chat stream for all roles
  Stream<List<Map<String, dynamic>>> getChatStream(
    String userId, 
    String receiverId
  ) {
    return _firestore
        .collection('chats')
        .where('senderId', whereIn: [userId, receiverId])
        .where('receiverId', whereIn: [userId, receiverId])
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc.id,
              'message': data['message'] ?? '',
              'senderId': data['senderId'] ?? '',
              'senderEmail': data['senderEmail'] ?? '',
              'senderRole': data['senderRole'] ?? '',
              'isRead': data['isRead'] ?? false,
              'timestamp': data['timestamp'] ?? Timestamp.now(),
            };
          }).toList()
            ..sort((a, b) => 
              (b['timestamp'] as Timestamp).compareTo(a['timestamp']));
        });
  }

  // Get all users for admin to chat with
  Future<List<Map<String, dynamic>>> getUsersForAdmin() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return [];

      // Verify admin role
      DocumentSnapshot adminDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      String role = adminDoc['role'] ?? '';
      if (role != 'admin') return [];

      // Fetch users with chat history
      QuerySnapshot userChatsSnapshot = await _firestore
          .collection('chats')
          .where('receiverId', isEqualTo: currentUser.uid)
          .get();

      Set<String> uniqueUserIds = userChatsSnapshot.docs
          .map((doc) => doc['senderId'] as String)
          .toSet();

      List<Map<String, dynamic>> userDetails = [];
      for (String userId in uniqueUserIds) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userId)
            .get();
        
        QuerySnapshot unreadMessages = await _firestore
            .collection('chats')
            .where('senderId', isEqualTo: userId)
            .where('receiverId', isEqualTo: currentUser.uid)
            .where('isRead', isEqualTo: false)
            .get();

        userDetails.add({
          'userId': userId,
          'email': userDoc['email'],
          'role': userDoc['role'],
          'unreadCount': unreadMessages.docs.length,
        });
      }

      return userDetails;
    } catch (e) {
      print('Users Fetch Error: $e');
      return [];
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String userId, String receiverId) async {
    try {
      QuerySnapshot unreadMessages = await _firestore
          .collection('chats')
          .where('senderId', isEqualTo: userId)
          .where('receiverId', isEqualTo: receiverId)
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in unreadMessages.docs) {
        await doc.reference.update({'isRead': true});
      }
    } catch (e) {
      print('Message Read Error: $e');
    }
  }
}