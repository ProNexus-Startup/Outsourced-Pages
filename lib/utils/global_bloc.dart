import 'package:flutter/material.dart';
import 'package:outsourced_pages/utils/models/call_tracker.dart';
import 'package:outsourced_pages/utils/models/project.dart';
import 'package:outsourced_pages/utils/models/user.dart';
import 'package:outsourced_pages/utils/sample_data.dart';
import "models/available_expert.dart";

class GlobalBloc with ChangeNotifier {
  // Example filter variables
  bool favoriteFilter = false;
  String geographyFilter = '';
  String availabilityFilter = '';
  // Adding a projectId filter variable
  String projectIdFilter = '';

  // Dummy filter maps added to define statusFilters, angleFilters, geographyFilters, and expertNetworkFilters
  // Adjust these maps according to your actual filters' requirements
  Map<String, bool> statusFilters = {};
  Map<String, bool> angleFilters = {};
  Map<String, bool> geographyFilters = {};
  Map<String, bool> expertNetworkFilters = {};

  void setFavoriteFilter(bool value) {
    favoriteFilter = value;
    notifyListeners();
  }

  void setGeographyFilter(String value) {
    geographyFilter = value;
    notifyListeners();
  }

  void setAvailabilityFilter(String value) {
    availabilityFilter = value;
    notifyListeners();
  }

  // Method to set the projectIdFilter
  void setProjectIdFilter(String value) {
    projectIdFilter = value;
    print(value);
    notifyListeners();
  }

/*
  bool applyFilters(AvailableExpert expert) {
    bool statusMatch = statusFilters[expert.status] ?? false;
    bool favoriteMatch = favoriteFilter ? expert.favorite : true;
    bool angleMatch = angleFilters.entries
        .any((entry) => entry.value && expert.angle.contains(entry.key));
    bool geographyMatch = geographyFilters.entries
        .any((entry) => entry.value && expert.geography.contains(entry.key));
    bool networkMatch = expertNetworkFilters.entries.any(
        (entry) => entry.value && expert.expertNetworkName.contains(entry.key));

    return statusMatch &&
        favoriteMatch &&
        angleMatch &&
        geographyMatch &&
        networkMatch;
  }
*/
  static final GlobalBloc _singleton = GlobalBloc._internal();

  factory GlobalBloc() {
    return _singleton;
  }

  GlobalBloc._internal() {
    expertList = [];
    callList = [];
    projectList = [];
    userProjectList = [];
    userList = [];
    currentUser = User.defaultUser();
  }

  late List<Project> projectList;
  late List<Project> userProjectList;
  late List<User> userList;
  late List<AvailableExpert> expertList;
  late List<CallTracker> callList;
  late User currentUser;

  List<AvailableExpert> get expertListStream => expertList;
  List<CallTracker> get callListStream => callList;
  List<Project> get projectListStream => projectList;
  List<Project> get userProjectListStream => userProjectList;
  List<User> get userListStream => userList;

  Future<void> onUserLogin(String token) async {
    List<AvailableExpert> fetchedExperts = Samples.experts;
    List<CallTracker> fetchedCalls = Samples.callTrackers;
    try {
      List<Project> fetchedProjects = Samples.sampleProjects;
      this.projectList = fetchedProjects;
    } catch (e) {
      print('Error fetching projects: $e');
    }
    List<User> fetchedUsers = Samples.all_users;

    // Apply filtering based on the projectId
    if (projectIdFilter.isNotEmpty) {
      fetchedExperts = fetchedExperts
          .where((expert) => expert.projectId == projectIdFilter)
          .toList();
      fetchedCalls = fetchedCalls
          .where((call) => call.projectId == projectIdFilter)
          .toList();
    }

    // Assigning filtered lists to the global state
    this.expertList = fetchedExperts;
    this.callList = fetchedCalls;
    this.userList = fetchedUsers;

    User user = Samples.sampleUser;
    this.currentUser = user;

    List<String> idsToFilter = user.pastProjectIDs ?? [];
    List<Project> filteredProjects = projectList
        .where((project) => idsToFilter.contains(project.projectId))
        .toList();

    this.userProjectList = filteredProjects;

    notifyListeners();
  }

  Future<void> onUserLogout() async {
    expertList = [];
    callList = [];
    projectList = [];
    userList = [];
    currentUser = User.defaultUser();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    expertList = [];
  }

  Map<String, Map<String, bool>> _activeFilters = {};

  void setFilter(String attribute, String value, bool isActive) {
    _activeFilters[attribute] ??= {};
    _activeFilters[attribute]![value] = isActive;
    notifyListeners();
  }

  bool isFilterOn(String attribute, String value) {
    return _activeFilters[attribute]?[value] ?? false;
  }

  bool expertMatchesFilter(
      AvailableExpert expert, String attribute, String value) {
    switch (attribute) {
      case 'Geography':
        return expert.geography == value;
      case 'Company':
        return expert.company == value;
      case 'Status':
        return expert.status == value;
      case 'Availability':
        return expert.availability == value;
      default:
        return false;
    }
  }

  void toggleFavorite(AvailableExpert expert) {
    int index = expertList.indexOf(expert);
    if (index != -1) {
      expertList[index].favorite = !(expertList[index].favorite);
      notifyListeners();
    }
  }

  void toggleScheduled(CallTracker call) {
    int index = callList.indexOf(call);
    if (index != -1) {
      callList[index].favorite = !(callList[index].favorite);
      notifyListeners();
    }
  }
}
