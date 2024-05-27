import 'package:flutter/material.dart';
import 'package:outsourced_pages/utils/models/call_tracker.dart';
import 'package:outsourced_pages/utils/models/expert_filter_model.dart';
import 'package:outsourced_pages/utils/models/project.dart';
import 'package:outsourced_pages/utils/models/user.dart';
import 'package:outsourced_pages/utils/sample_data.dart';

import "models/available_expert.dart";

class GlobalBloc with ChangeNotifier {
  // all experts list
  List<AvailableExpert> _allExperts = [];
  // filtered experts list based on the filters applied
  List<AvailableExpert> filteredExperts = [];
  // List of calls
  late List<CallTracker> callList;

  // get all experts list
  List<AvailableExpert> get allExperts => _allExperts;

  // List of filters to be applied
  List<ExpertFilterModel> filters = [
    ExpertFilterModel(filterValues: [], heading: 'status'),
    ExpertFilterModel(filterValues: [], heading: 'Favorite status'),
    ExpertFilterModel(filterValues: [], heading: 'Filter by angle'),
    ExpertFilterModel(filterValues: [], heading: 'Geography'),
    ExpertFilterModel(filterValues: [], heading: 'Expert network'),
  ];
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
      projectList = fetchedProjects;
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

  Future<void> getData() async {
    _allExperts = Samples.experts;
    callList = Samples.callTrackers;
    filteredExperts.clear();
    filteredExperts.addAll(_allExperts);
    updateExpertFilters();
    filterExperts();

    notifyListeners();
  }

  Future<void> filterAvailableExpert(List<ExpertFilterModel> filters) async {
    // Filter the experts based on the filters
    // filteredExperts = allExperts.where((expert) => applyFilters(expert)).toList();
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

  Future<void> filterExperts() async {
    filteredExperts.clear();
    List<AvailableExpert> allExpertA = [..._allExperts];
    _removeExtraExpert(allExpertA, filters[0],
        (expert, filterValue) => expert.status == filterValue.value);
    _removeExtraExpert(
        allExpertA,
        filters[1],
        (expert, filterValue) =>
            (expert.favorite ? "Favorite" : "Not Favorite") ==
            filterValue.value);
    _removeExtraExpert(allExpertA, filters[2],
        (expert, filterValue) => expert.angle == filterValue.value);
    _removeExtraExpert(allExpertA, filters[3],
        (expert, filterValue) => expert.geography == filterValue.value);
    _removeExtraExpert(allExpertA, filters[4],
        (expert, filterValue) => expert.expertNetworkName == filterValue.value);
    filteredExperts.clear();
    filteredExperts.addAll(allExpertA);
    // notifyListeners();
  }

  void _removeExtraExpert(
      List<AvailableExpert> allExpertA,
      ExpertFilterModel filterModel,
      bool Function(AvailableExpert, ExpertFilterValues) condition) {
    if (filterModel.filterValues.any((ExpertFilterValues e) => e.isSelected)) {
      for (ExpertFilterValues filterValue in filterModel.filterValues) {
        if (!filterValue.isSelected) {
          allExpertA.removeWhere((expert) => condition(expert, filterValue));
        }
      }
    } else {
      print("No filter selected");
    }
  }

  Future<void> updateExpertFilters() async {
    filterExperts();
    //update state of filters
    List<ExpertFilterModel> expertFiltersTemp = [];
    expertFiltersTemp.addAll(filters.map((e) => e.copyWith()));
    expertFiltersTemp[0].filterValues = _updateSingleFilters(
      expertFiltersTemp[0],
      (expert) => expert.status,
    );
    expertFiltersTemp[1].filterValues = _updateSingleFilters(
      expertFiltersTemp[1],
      (expert) => expert.favorite ? "Favorite" : "Not Favorite",
    );
    expertFiltersTemp[2].filterValues = _updateSingleFilters(
      expertFiltersTemp[2],
      (expert) => expert.angle,
    );
    expertFiltersTemp[3].filterValues = _updateSingleFilters(
      expertFiltersTemp[3],
      (expert) => expert.geography,
    );
    expertFiltersTemp[4].filterValues = _updateSingleFilters(
      expertFiltersTemp[4],
      (expert) => expert.expertNetworkName,
    );
    // update state of filters
    for (ExpertFilterModel filter in expertFiltersTemp) {
      filter.filterValues = filter.filterValues
          .map((e) => e.copyWith(
              isSelected: _isFilterSelected(filter.heading, e.value)))
          .toList();
    }
    filters = expertFiltersTemp;
    notifyListeners();
  }

  bool _isFilterSelected(String filterName, String value) {
    try {
      return filters
          .firstWhere((element) => element.heading == filterName)
          .filterValues
          .firstWhere((element) => element.value == value)
          .isSelected;
    } catch (e) {
      return false;
    }
  }

  List<ExpertFilterValues> _updateSingleFilters(
    ExpertFilterModel filter,
    String Function(AvailableExpert) toElement,
  ) {
    //update state of filters
    filter.filterValues = _allExperts
        .map(toElement)
        .toSet()
        .map((status) => ExpertFilterValues(
            value: status,
            isSelected: false,
            count: filteredExperts
                .where((expert) => toElement(expert) == status)
                .length
                .toString()))
        .toList();
    return filter.filterValues;
  }
}
