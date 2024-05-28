import 'package:flutter/material.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:provider/provider.dart';

class SubMenu extends StatelessWidget {
  final Function(String) onItemSelected;
  final String projectName;

  const SubMenu(
      {Key? key, required this.onItemSelected, required this.projectName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<GlobalBloc>(context, listen: false).getData();
    return Container(
      height: 80,

      color: Colors.white60, // Adjust the background color to match your navbar
      child: Row(
        children: [
          SizedBox(
            width: 365,
            child: Row(
              children: <Widget>[
                const SizedBox(width: 30),
                _menuItem(projectName, () {}),
              ],
            ),
          ),
          Expanded(
            child: Consumer<GlobalBloc>(builder: (context, globalBloc, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _menuItem("Draft angle outreach",
                      () => onItemSelected("Draft angle outreach"),
                      isDropdown: true),
                  _menuItem("Project dashboard",
                      () => onItemSelected("Project dashboard"),
                      isDropdown: true),
                  _menuItem("Available experts", () async {
                    Navigator.pushNamed(context, '/available-expert');
                  },
                      countValue: globalBloc.allExperts.length,
                      isSelected: ModalRoute.of(context)!.settings.name ==
                          '/available-expert'),
                  _menuItem("Call tracker", () async {
                    Navigator.pushNamed(context, '/call-tracker');
                  },
                      countValue: globalBloc.callList.length,
                      isSelected: ModalRoute.of(context)!.settings.name ==
                          '/call-tracker'),
                  _menuItem(
                      "Project info", () => onItemSelected("Project info"),
                      isDropdown: true),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String title, VoidCallback onTap,
      {bool isDropdown = false, int? countValue, bool isSelected = false}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(title, style: isSelected ? customSelectedStyle : customStyle),
            if (isDropdown)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.keyboard_arrow_down,
                    color: isSelected ? blueColor : greyColor),
              ),
            if (countValue != null)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: isSelected ? blueColor : greyColor,
                  child: Text(
                    countValue.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static const TextStyle customStyle =
      TextStyle(color: greyColor, fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle customSelectedStyle =
      TextStyle(color: blueColor, fontSize: 14, fontWeight: FontWeight.w500);
}
