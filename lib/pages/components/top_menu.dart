import 'package:flutter/material.dart';
import 'package:outsourced_pages/pages/home_page.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:provider/provider.dart';

class TopMenu extends StatelessWidget {
  TopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc =
        Provider.of<GlobalBloc>(context, listen: false);

    return Container(
      color: Colors.blue[800],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()), // Use MaterialPageRoute
              );
            },
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          if (globalBloc.currentUser.admin)
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage()), // Use MaterialPageRoute
                );
              },
              child: const Text('Admin view',
                  style: TextStyle(color: Colors.white)),
            ),
          const Spacer(), // Pushes following items to the right
          const Text('Chat with live support',
              style: TextStyle(color: Colors.white)),
          IconButton(
              icon: const Icon(Icons.chat, color: Colors.white),
              onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
