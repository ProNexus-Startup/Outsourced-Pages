import 'package:flutter/material.dart';
import 'package:outsourced_pages/pages/components/action_card.dart';
import 'package:outsourced_pages/pages/components/call_table.dart';
import 'package:outsourced_pages/pages/components/sub_menu.dart';
import 'package:outsourced_pages/pages/components/top_menu.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:outsourced_pages/utils/models/available_expert.dart';
import 'package:provider/provider.dart';

class CallTrackerDashboard extends StatefulWidget {
  final String token = 'tokenabc';

  const CallTrackerDashboard({Key? key}) : super(key: key);

  @override
  _CallTrackerDashboardState createState() => _CallTrackerDashboardState();
}

class _CallTrackerDashboardState extends State<CallTrackerDashboard> {
  bool isAnySelected = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // final GlobalBloc globalBloc =
    //     Provider.of<GlobalBloc>(context, listen: false);
    // globalBloc.onUserLogin(widget.token);
    Provider.of<GlobalBloc>(context, listen: false).getData();
  }

  // Update this based on checkbox changes
  void updateSelection(bool isSelected) {
    setState(() {
      isAnySelected = isSelected;
    });
  }

  Future<void> _showAddExpertDialog(BuildContext context, String orgId) async {
    String projectId = "projectxyz";

    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController companyController = TextEditingController();
    TextEditingController companyTypeController = TextEditingController();
    TextEditingController yearsAtCompanyController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController geographyController = TextEditingController();
    TextEditingController angleController = TextEditingController();
    TextEditingController statusController = TextEditingController();
    TextEditingController commentsController = TextEditingController();
    TextEditingController costController = TextEditingController();
    List<String> screeningQuestions = [];
    bool isSelected = false;
    bool favorite = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Expert'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    TextField(
                      controller: companyController,
                      decoration: InputDecoration(hintText: "Company"),
                    ),
                    TextField(
                      controller: companyTypeController,
                      decoration: InputDecoration(hintText: "Company Type"),
                    ),
                    TextField(
                      controller: yearsAtCompanyController,
                      decoration: InputDecoration(hintText: "Years at Company"),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(hintText: "Description"),
                    ),
                    TextField(
                      controller: geographyController,
                      decoration: InputDecoration(hintText: "Geography"),
                    ),
                    TextField(
                      controller: angleController,
                      decoration: InputDecoration(hintText: "Angle"),
                    ),
                    TextField(
                      controller: statusController,
                      decoration: InputDecoration(hintText: "Status"),
                    ),
                    TextField(
                      controller: commentsController,
                      decoration: InputDecoration(hintText: "Comments"),
                    ),
                    TextField(
                      controller: costController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Cost"),
                    ),
                    // Additional inputs like Switches or Checkboxes for isSelected, favorite, etc., can be added here if needed.
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    AvailableExpert newExpert = AvailableExpert(
                      isSelected: isSelected,
                      aIAnalysis: '',
                      trends: '',
                      favorite: favorite,
                      expertId:
                          '', // This should be generated or handled elsewhere
                      name: nameController.text,
                      organizationId: orgId,
                      projectId: projectId,
                      title: titleController.text,
                      company: companyController.text,
                      companyType: companyTypeController.text,
                      yearsAtCompany: yearsAtCompanyController.text,
                      description: descriptionController.text,
                      geography: geographyController.text,
                      angle: angleController.text,
                      status: statusController.text,
                      AIAssessment: 0,
                      comments: commentsController.text,
                      availability: 'Available',
                      expertNetworkName: '',
                      cost: double.parse(costController.text),
                      screeningQuestions: screeningQuestions,
                      addedExpertBy: '',
                      dateAddedExpert: DateTime.now(),
                    );
                    //make expert function
                    Provider.of<GlobalBloc>(context, listen: false).getData();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalBloc>(builder: (context, globalBloc, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: [
            TopMenu(),
            SubMenu(
              onItemSelected: (String item) {
                print("Selected: $item"); // Example action
              },
              projectName: "Project name here later",
            ),
            Row(
              children: [
                const SizedBox(width: 128),
                const ActionCard(
                  title: 'Send unscheduled invites to team',
                  backgroundColor: blueColor,
                  foregroundColor: Colors.white,
                  hasBorder: false,
                ),
                const SizedBox(width: 50),
                // ActionCard(
                //   title: 'Shown as: Compact List',
                //   leadingIcon: Image.asset('assets/icons/sort_desc.png',
                //       height: 20, width: 20),
                //   trailingIcon: const Icon(
                //     Icons.keyboard_arrow_down,
                //     color: greyColor,
                //   ),
                // ),
                // const SizedBox(width: 20),
                ActionCard(
                  title: 'Search Live Projects',
                  onChanged: (val) {
                    setState(() {});
                  },
                  controller: globalBloc.searchController,
                  isTextfield: true,
                  leadingIcon: Image.asset('assets/icons/search.png',
                      height: 24, width: 24),
                ),
                const Spacer(),
                const ActionCard(
                  title: 'Download Experts',
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 26),
            Expanded(child: CallTable(callsList: globalBloc.filteredCalls)),
          ]));
    });
  }
}
