import 'package:flutter/material.dart';
import 'package:sanad_app/screans/navigation-bar/maintenace_nav_bar.dart';

class MPDashboard extends StatefulWidget {
  const MPDashboard({super.key});

  @override
  State<MPDashboard> createState() => _MPDashboardState();
}

class _MPDashboardState extends State<MPDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('لوحة')),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          DashboardTile(
            title: ' عدد الطلبات الكلي',
            value: '10',
            iconData: Icons.format_list_numbered,
          ),
          DashboardTile(
            title: 'الطبيات الملغية',
            value: '1',
            iconData: Icons.cancel,
          ),
          DashboardTile(
            title: 'الطلبات المكتملة',
            value: '15',
            iconData: Icons.check_circle_outline,
          ),
          DashboardTile(
            title: 'الطلبات الجاري تنفيذها',
            value: '14 ',
            iconData: Icons.pending_actions,
          ),
          DashboardTile(
            title: 'عدد الغرف في  النظام',
            value: '10',
            iconData: Icons.meeting_room,
          ),
        ],
      ),
      bottomNavigationBar: MpNBar(),
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
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
