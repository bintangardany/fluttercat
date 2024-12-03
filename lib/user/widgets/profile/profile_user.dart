import 'package:flutter/material.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEditProfileButton(context),
                  SizedBox(height: 20),
                  _SectionTitle('Personal Information'),
                  _InfoCard(
                    items: [
                      _InfoItem(icon: Icons.phone, text: 'Phone:'),
                      _InfoItem(icon: Icons.golf_course, text: 'Gender:'),
                      _InfoItem(icon: Icons.cake, text: 'Date of Birth:'),
                    ],
                  ),
                  SizedBox(height: 20),
                  _SectionTitle('Address Information'),
                  _InfoCard(
                    items: [
                      _InfoItem(icon: Icons.home, text: 'Street:'),
                      _InfoItem(icon: Icons.location_city, text: 'Province:'),
                      _InfoItem(icon: Icons.map, text: 'City:'),
                      _InfoItem(icon: Icons.location_on, text: 'District:'),
                      _InfoItem(icon: Icons.flag, text: 'Sub District:'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(color: Color(0xFF4A1E9E)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/cat1.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Rizky',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'rizky@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildEditProfileButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showEditProfileDialog(context),
      icon: Icon(Icons.edit),
      label: Text('Edit Profile'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4A1E9E),
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Implement save functionality
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A1E9E),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<_InfoItem> items;

  const _InfoCard({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: items
            .map((item) => _InfoTile(icon: item.icon, text: item.text))
            .toList(),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String text;

  _InfoItem({required this.icon, required this.text});
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoTile({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4A1E9E)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
