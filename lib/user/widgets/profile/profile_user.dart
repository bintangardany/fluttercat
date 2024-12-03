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
                  SizedBox(height: 10),
                  _SectionTitle('Personal Information'),
                  _InfoCard(
                    items: [
                      _InfoItem(
                        icon: Icons.phone,
                        label: 'Phone:',
                        value: '082110147321',
                      ),
                      _InfoItem(
                          icon: Icons.golf_course,
                          label: 'Gender:',
                          value: 'Male'),
                      _InfoItem(
                          icon: Icons.cake,
                          label: 'Date of Birth:',
                          value: '2000-01-01'),
                    ],
                  ),
                  SizedBox(height: 10),
                  _SectionTitle('Address Information'),
                  _InfoCard(
                    items: [
                      _InfoItem(icon: Icons.home, label: 'Street:', value: ''),
                      _InfoItem(
                          icon: Icons.location_city,
                          label: 'Province:',
                          value: ''),
                      _InfoItem(icon: Icons.map, label: 'City:', value: ''),
                      _InfoItem(
                          icon: Icons.location_on,
                          label: 'District:',
                          value: ''),
                      _InfoItem(
                          icon: Icons.flag, label: 'Sub District:', value: ''),
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
                  'rizky',
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

  Widget _buildEditProfileButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () => _showEditProfileDialog(context),
          icon: Icon(Icons.edit),
          label: Text('Edit Profile'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4A1E9E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
            .map((item) => _InfoTile(
                  icon: item.icon,
                  label: item.label,
                  value: item.value,
                  isRightAligned: item.isRightAligned,
                ))
            .toList(),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  final bool isRightAligned;

  _InfoItem(
      {required this.icon,
      required this.label,
      required this.value,
      this.isRightAligned = false});
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isRightAligned;

  const _InfoTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.isRightAligned = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.grey[300]!, width: 0.5), // Adding bottom border
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Color(0xFF4A1E9E)),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Spacer(), // This will push the value to the right side
            if (value.isNotEmpty)
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
