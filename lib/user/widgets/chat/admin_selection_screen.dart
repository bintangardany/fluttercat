// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'chat_user.dart';

// class AdminSelectionScreen extends StatefulWidget {
//   const AdminSelectionScreen({super.key});

//   @override
//   _AdminSelectionScreenState createState() => _AdminSelectionScreenState();
// }

// class _AdminSelectionScreenState extends State<AdminSelectionScreen> {
//   List<Map<String, dynamic>> _adminList = [];
//   bool _isLoading = true;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchAdminList();
//   }

//   Future<void> _fetchAdminList() async {
//     try {
//       // Fetch all admin users
//       QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('role', isEqualTo: 'admin')
//           .get();

//       setState(() {
//         _adminList = adminSnapshot.docs.map((doc) {
//           return {
//             'id': doc.id,
//             'email': doc['email'] ?? 'No email', // Fallback if 'email' is null
//             'role': doc['role'] ?? 'No role',    // Fallback if 'role' is null
//             // 'unreadCount': doc['unreadCount'] ?? 0, 
//           };
//         }).toList();
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error fetching admin list: $e';
//         _isLoading = false;
//       });
//     }
//   }

//   void _navigateToChatScreen(String adminId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UserChatScreen(adminId: adminId),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Select Admin',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF4A1E9E),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//               ? Center(
//                   child: Text(
//                     _errorMessage,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: _adminList.length,
//                   itemBuilder: (context, index) {
//                     final admin = _adminList[index];
//                     final email = admin['email'] ?? 'No email'; // Fallback for null email
//                     // final unreadCount = admin['unreadCount'] ?? 0;
//                     return ListTile(
//                       onTap: () => _navigateToChatScreen(admin['id']),
//                       leading: CircleAvatar(
//                         child: Text(
//                           email.isNotEmpty ? email[0].toUpperCase() : 'A', // Fallback for empty email
//                         ),
//                       ),
//                       title: Text(email),
//                       subtitle: Text(admin['role']),
//                       // trailing: unreadCount > 0
//                     );
//                   },
//                 ),
//     );
//   }
// }
