import 'package:flutter/material.dart';
import 'package:outsourced_pages/pages/components/action_card.dart';
import 'package:outsourced_pages/pages/components/sidebar.dart';
import 'package:outsourced_pages/pages/components/sub_menu.dart';
import 'package:outsourced_pages/pages/components/top_menu.dart';
import 'package:outsourced_pages/pages/components/expert_table.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:outsourced_pages/utils/models/available_expert.dart';
import 'package:outsourced_pages/utils/models/expert_filter_model.dart';
import 'package:provider/provider.dart';

class AvailableExpertsDashboard extends StatefulWidget {
  final String token = 'tokenabc';

  const AvailableExpertsDashboard({Key? key}) : super(key: key);

  @override
  _AvailableExpertsDashboardState createState() =>
      _AvailableExpertsDashboardState();
}

class _AvailableExpertsDashboardState extends State<AvailableExpertsDashboard> {
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
    // context.read<GlobalBloc>().onUserLogin(widget.token);
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
              title: const Text('Add New Expert'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(hintText: "Title"),
                    ),
                    TextField(
                      controller: companyController,
                      decoration: const InputDecoration(hintText: "Company"),
                    ),
                    TextField(
                      controller: companyTypeController,
                      decoration:
                          const InputDecoration(hintText: "Company Type"),
                    ),
                    TextField(
                      controller: yearsAtCompanyController,
                      decoration:
                          const InputDecoration(hintText: "Years at Company"),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(hintText: "Description"),
                    ),
                    TextField(
                      controller: geographyController,
                      decoration: const InputDecoration(hintText: "Geography"),
                    ),
                    TextField(
                      controller: angleController,
                      decoration: const InputDecoration(hintText: "Angle"),
                    ),
                    TextField(
                      controller: statusController,
                      decoration: const InputDecoration(hintText: "Status"),
                    ),
                    TextField(
                      controller: commentsController,
                      decoration: const InputDecoration(hintText: "Comments"),
                    ),
                    TextField(
                      controller: costController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Cost"),
                    ),
                    // Additional inputs like Switches or Checkboxes for isSelected, favorite, etc., can be added here if needed.
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add'),
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
    // context.read<GlobalBloc>().onUserLogin(widget.token);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(100), // Set the height of the app bar
            child: TopMenu()),
        body: Consumer<GlobalBloc>(builder: (context, globalBloc, child) {
          return Column(children: [
            SubMenu(
              onItemSelected: (String item) {
                print("Selected: $item"); // Example action
              },
              projectName: "Project name here later",
            ),
            Row(
              children: [
                const SizedBox(width: 55),
                Text('${globalBloc.filteredExperts.length} Experts found',
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                // ActionCard(
                //   title: 'Shown as: Compact List',
                //   leadingIcon: Image.asset('assets/icons/sort_desc.png',
                //       height: 20, width: 20),
                //   trailingIcon: const Icon(
                //     Icons.keyboard_arrow_down,
                //     color: greyColor,
                //   ),
                // ),
                const SizedBox(width: 20),
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
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 55),
                  SizedBox(
                    width: 310,
                    child: Sidebar(
                      globalBloc: globalBloc,
                      onFilterValueSelected:
                          (ExpertFilterValues filterValue, bool isSelected) {
                        setState(() {
                          filterValue.isSelected = isSelected;
                          globalBloc.updateExpertFilters();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ExpertTable(
                      experts: globalBloc.filteredExperts,
                      onFavoriteChange: (val, expert) {
                        setState(() {
                          expert.favorite = val;
                          globalBloc.updateExpertFilters();
                        });
                      },
                    ),
                  )
                ],
              ),
            )
            // Expanded(
            //   child: DemoPage(),
            // )
          ]);
        }));
  }
}
