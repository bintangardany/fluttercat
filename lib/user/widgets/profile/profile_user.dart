import 'package:flutter/material.dart';
import 'widgets.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EditProfileButton(),
                  const SizedBox(height: 10),
                  const SectionTitle('Personal Information'),
                  InfoCard(
                    items: [
                      InfoItem(
                          icon: Icons.phone,
                          label: 'Phone:',
                          value: '082110147321'),
                      InfoItem(
                          icon: Icons.golf_course,
                          label: 'Gender:',
                          value: 'Male'),
                      InfoItem(
                          icon: Icons.cake,
                          label: 'Date of Birth:',
                          value: '2000-01-01'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const SectionTitle('Address Information'),
                  InfoCard(
                    items: [
                      InfoItem(icon: Icons.home, label: 'Street:', value: 'Jl. Teratai No.217, RT.001/RW.008'),
                                            InfoItem(
                          icon: Icons.flag, label: 'Sub District:', value: 'Ciketing Udik'),
                                                InfoItem(
                          icon: Icons.location_on,
                          label: 'District:',
                          value: 'Bantargebang'),
                      InfoItem(icon: Icons.map, label: 'City:', value: 'Kota Bekasi'),
                                            InfoItem(
                          icon: Icons.location_city,
                          label: 'Province:',
                          value: 'Jawa Barat'),

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
}
