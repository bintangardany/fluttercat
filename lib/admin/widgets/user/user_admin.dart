import 'package:flutter/material.dart';

class UserAdmin extends StatelessWidget {
  const UserAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Management',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4A1E9E),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Gender')),
              DataColumn(label: Text('Date of Birth')),
              DataColumn(label: Text('Street')),
              DataColumn(label: Text('Sub District')),
              DataColumn(label: Text('District')),
              DataColumn(label: Text('City')),
              DataColumn(label: Text('Province')),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('Bintang Rizky')),
                const DataCell(Text('082110147321')),
                const DataCell(Text('Male')),
                const DataCell(Text('2000-01-01')),
                const DataCell(Text('Jl. Teratai No.217')),
                const DataCell(Text('Ciketing Udik')),
                const DataCell(Text('Bantargebang')),
                const DataCell(Text('Kota Bekasi')),
                const DataCell(Text('Jawa Barat')),
              ]),
              // Tambahkan DataRow lainnya jika diperlukan
            ],
          ),
        ),
      ),
    );
  }
}
