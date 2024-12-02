// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutternews/pages/onboarding.dart';
import 'package:flutternews/user/widgets/app_bar.dart';
import 'package:flutternews/user/widgets/banner_section.dart';
import 'package:flutternews/user/widgets/bottom_navigation.dart';
import 'package:flutternews/user/widgets/welcome_section.dart';
import 'package:flutternews/user/widgets/category_section.dart';
import 'package:flutternews/user/widgets/featured_products.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WelcomeSection(),
        CategorySection(),
        FeaturedProducts(),
        BannerSection(),
      ],
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Chat'));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Profile'));
}
