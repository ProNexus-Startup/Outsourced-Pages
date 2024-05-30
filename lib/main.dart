import 'package:flutter/material.dart';
import 'package:outsourced_pages/pages/available_experts_page.dart';
import 'package:outsourced_pages/pages/call_tracker_page.dart';
import 'package:outsourced_pages/pages/home_page.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ListenableProvider<GlobalBloc>(
    create: (_) => GlobalBloc(),
    child: ProNexus(),
  ));
}

class ProNexus extends StatefulWidget {
  const ProNexus({super.key});

  @override
  _ProNexusState createState() => _ProNexusState();
}

class _ProNexusState extends State<ProNexus> {
  Key key = UniqueKey();

  void resetGlobalBloc() {
    setState(() {
      key = UniqueKey(); // Changing the key rebuilds the widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProNexus',
      initialRoute: '/available-expert',
      routes: {
        '/': (context) => HomePage(),
        '/available-expert': (context) => AvailableExpertsDashboard(),
        '/call-tracker': (context) => CallTrackerDashboard(),
      },
      theme: wgerLightTheme,
    );
  }
}
