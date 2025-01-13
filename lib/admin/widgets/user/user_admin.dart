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
            rows: const [
              DataRow(cells: [
                DataCell(Text('Bintang Rizky')),
                DataCell(Text('082110147321')),
                DataCell(Text('Male')),
                DataCell(Text('2000-01-01')),
                DataCell(Text('Jl. Teratai No.217')),
                DataCell(Text('Ciketing Udik')),
                DataCell(Text('Bantargebang')),
                DataCell(Text('Kota Bekasi')),
                DataCell(Text('Jawa Barat')),
              ]),
              DataRow(cells: [
                DataCell(Text('Ayu Lestari')),
                DataCell(Text('081234567890')),
                DataCell(Text('Female')),
                DataCell(Text('1995-03-15')),
                DataCell(Text('Jl. Mawar Indah No.12')),
                DataCell(Text('Cimahi Tengah')),
                DataCell(Text('Cimahi')),
                DataCell(Text('Kota Cimahi')),
                DataCell(Text('Jawa Barat')),
              ]),
              DataRow(cells: [
                DataCell(Text('Rendi Pratama')),
                DataCell(Text('085678901234')),
                DataCell(Text('Male')),
                DataCell(Text('1998-07-22')),
                DataCell(Text('Jl. Melati No.45')),
                DataCell(Text('Kalideres')),
                DataCell(Text('Jakarta Barat')),
                DataCell(Text('DKI Jakarta')),
                DataCell(Text('Jakarta')),
              ]),
              DataRow(cells: [
                DataCell(Text('Siti Aminah')),
                DataCell(Text('082345678912')),
                DataCell(Text('Female')),
                DataCell(Text('1988-11-05')),
                DataCell(Text('Jl. Dahlia No.78')),
                DataCell(Text('Medan Satria')),
                DataCell(Text('Bekasi Utara')),
                DataCell(Text('Kota Bekasi')),
                DataCell(Text('Jawa Barat')),
              ]),
              DataRow(cells: [
                DataCell(Text('Agus Saputra')),
                DataCell(Text('081987654321')),
                DataCell(Text('Male')),
                DataCell(Text('1992-06-30')),
                DataCell(Text('Jl. Kenanga No.101')),
                DataCell(Text('Denpasar Selatan')),
                DataCell(Text('Denpasar')),
                DataCell(Text('Kota Denpasar')),
                DataCell(Text('Bali')),
              ]),
              DataRow(cells: [
                DataCell(Text('Dewi Sartika')),
                DataCell(Text('083123456789')),
                DataCell(Text('Female')),
                DataCell(Text('1990-02-14')),
                DataCell(Text('Jl. Anggrek No.9')),
                DataCell(Text('Sukolilo')),
                DataCell(Text('Surabaya Timur')),
                DataCell(Text('Kota Surabaya')),
                DataCell(Text('Jawa Timur')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
