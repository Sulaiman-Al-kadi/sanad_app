import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanad_app/screans/navigation-bar/admin_nav_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<Map<String, dynamic>> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = _fetchDashboardData();
  }

  Future<Map<String, dynamic>> _fetchDashboardData() async {
    int totalOrders = await _firestore
        .collection('requests')
        .get()
        .then((snapshot) => snapshot.size);

    int cancelledOrders = await _firestore
        .collection('requests')
        .where('state', isEqualTo: 'cancelled')
        .get()
        .then((snapshot) => snapshot.size);

    int completedOrders = await _firestore
        .collection('requests')
        .where('state', isEqualTo: 'completed')
        .get()
        .then((snapshot) => snapshot.size);

    int ongoingOrders = await _firestore
        .collection('requests')
        .where('state', isEqualTo: 'onProgress')
        .get()
        .then((snapshot) => snapshot.size);

    int rooms = await _firestore
        .collection('location')
        .get()
        .then((snapshot) => snapshot.size);

    return {
      'totalOrders': totalOrders,
      'cancelledOrders': cancelledOrders,
      'completedOrders': completedOrders,
      'ongoingOrders': ongoingOrders,
      'rooms': rooms,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('لوحة التحكم')),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            Map<String, dynamic> data = snapshot.data!;
            return GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                DashboardTile(
                  title: ' عدد الطلبات الكلي',
                  value: data['totalOrders'].toString(),
                  iconData: Icons.format_list_numbered,
                ),
                DashboardTile(
                  title: 'الطبيات الملغية',
                  value: data['cancelledOrders'].toString(),
                  iconData: Icons.cancel,
                ),
                DashboardTile(
                  title: 'الطلبات المكتملة',
                  value: data['completedOrders'].toString(),
                  iconData: Icons.check_circle_outline,
                ),
                DashboardTile(
                  title: 'الطلبات الجاري تنفيذها',
                  value: data['ongoingOrders'].toString(),
                  iconData: Icons.pending_actions,
                ),
                DashboardTile(
                  title: 'عدد الغرف في النظام',
                  value: data['rooms'].toString(),
                  iconData: Icons.meeting_room,
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: const AdminNBar(),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;

  const DashboardTile({
    Key? key,
    required this.title,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
