import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outsourced_pages/pages/home_page.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:provider/provider.dart';

class TopMenu extends StatelessWidget {
  TopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc =
        Provider.of<GlobalBloc>(context, listen: false);

    return Container(
      height: 80,
      color: blueColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 190,
          ),
          Expanded(
            child: Row(
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           HomePage()), // Use MaterialPageRoute
                    // );
                  },
                  child: const Text('Home', style: customStyle),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           HomePage()), // Use MaterialPageRoute
                    // );
                  },
                  child: const Text('All projects', style: customStyle),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/');

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           HomePage()), // Use MaterialPageRoute
                    // );
                  },
                  child: const Text('Start new project', style: customStyle),
                ),
                if (globalBloc.currentUser.admin)
                  TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/');

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           HomePage()), // Use MaterialPageRoute
                      // );
                    },
                    child: const Text('Admin view', style: customStyle),
                  ),
              ],
            ),
          ),
          TextButton.icon(
              onPressed: () {},
              label: const Text('Chat with live support', style: customStyle),
              icon: Image.asset('assets/icons/chat_icon.png',
                  height: 24, width: 24)),
          TextButton.icon(
              onPressed: () {},
              label: const Text('Log out', style: customStyle),
              icon: const Icon(Icons.exit_to_app, color: Colors.white)),
          // const Text('Chat with live support',
          //     style: TextStyle(color: Colors.white)),
          // IconButton(
          //     icon: const Icon(Icons.chat, color: Colors.white),
          //     onPressed: () {}),
          // IconButton(
          //   icon: const Icon(Icons.exit_to_app),
          //   color: Colors.white,
          //   onPressed: () {},
          // ),
          const SizedBox(
            width: 160,
          ),
        ],
      ),
    );
  }

  static const TextStyle customStyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);
}
