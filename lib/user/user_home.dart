import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/app_bar.dart';
import 'package:flutternews/user/widgets/banner/banner_section.dart';
import 'package:flutternews/user/widgets/bottom_navigation.dart';
import 'package:flutternews/user/widgets/cat/cat_product.dart';
// import 'package:flutternews/user/widgets/chat/admin_selection_screen.dart';
import 'package:flutternews/user/widgets/chat/chat_user.dart';
import 'package:flutternews/user/widgets/food/food_product.dart';
import 'package:flutternews/user/widgets/cage/cage_product.dart';
import 'package:flutternews/user/widgets/profile/profile_user.dart';
import 'package:flutternews/user/widgets/order/transactions_section.dart';
import 'package:flutternews/user/widgets/home/welcome_section.dart';
import 'package:flutternews/user/widgets/home/slider_section.dart';
import 'package:flutternews/user/widgets/category/category_section.dart';
import 'package:flutternews/user/widgets/featured/featured_products.dart';

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
    OrderPage(),
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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WelcomeSection(),
        EnhancedPromoSlider(),
        CategorySection(),
        FeaturedProducts(),
        BannerSection(),
        CatProducts(),
        FoodProducts(),
        CageProducts(),
        SizedBox(height: 12.0,),
      ],
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => UserChatScreen();
}

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) => TransactionsPage();
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => ProfileUser();
}
