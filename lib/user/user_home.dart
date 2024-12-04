import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/app_bar.dart';
import 'package:flutternews/user/widgets/banner_section.dart';
import 'package:flutternews/user/widgets/bottom_navigation.dart';
import 'package:flutternews/user/widgets/cat_product.dart';
import 'package:flutternews/user/widgets/chat/chat_user.dart';
import 'package:flutternews/user/widgets/food_product.dart';
import 'package:flutternews/user/widgets/cage_product.dart';
import 'package:flutternews/user/widgets/profile/profile_user.dart';
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
    TransactionsPage(),
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
    return ListView(
      children: [
        WelcomeSection(),
        CategorySection(),
        FeaturedProducts(),
        BannerSection(),
        CatProducts(),
        FoodProducts(),
        CageProducts(),
      ],
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => UserChatScreen();
}

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text('blom jadi');
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ProfileUser();
}
