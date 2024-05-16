import 'package:flutter/material.dart';
import 'package:outsourced_pages/pages/available_experts_page.dart';
import 'package:outsourced_pages/pages/call_tracker_page.dart';

class SubMenu extends StatelessWidget {
  final Function(String) onItemSelected;
  final String projectName;

  const SubMenu(
      {Key? key, required this.onItemSelected, required this.projectName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60, // Adjust the background color to match your navbar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _menuItem(projectName, () {}),
          _menuItem("Draft angle outreach",
              () => onItemSelected("Draft angle outreach")),
          _menuItem(
              "Project dashboard", () => onItemSelected("Project dashboard")),
          _menuItem("Available experts", () async {
            Navigator.pushNamed(
              context,
              AvailableExpertsDashboard.routeName,
            );
          }),
          _menuItem("Call tracker", () async {
            Navigator.pushNamed(
              context,
              CallTrackerDashboard.routeName,
            );
          }),
          _menuItem("Project info", () => onItemSelected("Project info")),
        ],
      ),
    );
  }

  Widget _menuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(title,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
