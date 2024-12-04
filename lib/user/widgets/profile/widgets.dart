import 'package:flutter/material.dart';

/// SliverAppBar Widget
class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(color: Color(0xFF4A1E9E)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/cat1.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'rizky',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'rizky@gmail.com',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Edit Profile Button
class EditProfileButton extends StatelessWidget {
  const EditProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => _showEditProfileDialog(context),
          icon: const Icon(Icons.edit),
          label: const Text('Edit Profile'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A1E9E),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                TextField(decoration: InputDecoration(labelText: 'Name')),
                TextField(decoration: InputDecoration(labelText: 'Email')),
                TextField(decoration: InputDecoration(labelText: 'Phone')),
                TextField(decoration: InputDecoration(labelText: 'Gender')),
                TextField(
                    decoration: InputDecoration(labelText: 'Date of Birth')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/// Section Title
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A1E9E)),
      ),
    );
  }
}

/// InfoCard Widget
class InfoCard extends StatelessWidget {
  final List<InfoItem> items;

  const InfoCard({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: items
            .map((item) =>
                InfoTile(icon: item.icon, label: item.label, value: item.value))
            .toList(),
      ),
    );
  }
}

/// InfoTile Widget
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTile(
      {Key? key, required this.icon, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4A1E9E)),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

/// InfoItem Model (Jika Perlu untuk Keperluan Lain)
class InfoItem {
  final IconData icon;
  final String label;
  final String value;

  InfoItem({required this.icon, required this.label, required this.value});
}
