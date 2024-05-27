import 'package:outsourced_pages/utils/models/available_expert.dart';
import 'package:outsourced_pages/utils/models/call_tracker.dart';
import 'package:outsourced_pages/utils/models/project.dart';
import 'package:outsourced_pages/utils/models/user.dart';

class Samples {
  static User sampleUser = User(
    userId: '12345',
    email: 'john.doe@example.com',
    fullName: 'John Doe',
    password: "password123",
    organizationId: 'org123',
    projectId: 'proj123',
    dateOnboarded: DateTime.now(),
    pastProjectIDs: ['proj001', 'proj002', 'proj003'],
    admin: true,
    signedAt: DateTime.now(),
    token: 'someUniqueToken123456789',
  );

  static List<AvailableExpert> experts = List.generate(10, (index) {
    return AvailableExpert(
      favorite: index == 1,
      trends: index % 2 == 0 ? 'Trend ${index + 1}' : "",
      aIAnalysis: index % 2 == 0 ? 'Ai Analysis ${index + 1}' : "lorem ipsum",
      expertId: 'exp${index + 1}',
      name: 'Expert Name ${index + 1}',
      organizationId: 'org${index % 3 + 1}',
      projectId: 'projectxyz',
      title: 'Expert Title ${index + 1}',
      company: 'Company ${index % 4 + 1}',
      companyType: index % 2 == 0 ? 'Public' : 'Private',
      yearsAtCompany: '${index + 1} years',
      description: 'Expertise in field ${index + 1}',
      geography: index % 2 == 0 ? 'North America' : 'Europe',
      angle: 'Angle ${index + 1}',
      status: index % 2 == 0 ? 'Active' : 'Inactive',
      AIAssessment: index * 10 + 50,
      comments: 'Performance review ${index + 1}',
      availability: index % 2 == 0 ? 'Available' : 'Unavailable',
      expertNetworkName: 'Network ${index % 3 + 1}',
      cost: (index + 1) * 100.0,
      screeningQuestions: [
        'What is your background in ${index % 3 + 1}?',
        'How do you handle stress?',
        'What are your key achievements?'
      ],
      addedExpertBy: 'Admin${index % 2 + 1}',
      dateAddedExpert: DateTime.now().subtract(Duration(days: index * 10)),
    );
  });

  static List<CallTracker> callTrackers = List.generate(5, (index) {
    return CallTracker(
        inviteSent: index % 3 == 0,
        expertId: 'exp${index + 1}',
        name: 'Expert Name ${index + 1}',
        projectId: 'projectxyz',
        organizationId: 'org${index % 3 + 1}',
        organizationName: 'Organization ${index % 3 + 1}',
        source: 'Source ${index % 3 + 1}',
        sourceByCompany: 'Company ${index % 3 + 1}',
        attribution: 'Attribution ${index % 3 + 1}',
        title: 'Expert Title ${index + 1}',
        company: 'Company ${index % 4 + 1}',
        companyType: index % 2 == 0 ? 'Public' : 'Private',
        yearsAtCompany: index + 1,
        description: 'Expertise in field ${index + 1}',
        geography: index % 2 == 0 ? 'North America' : 'Europe',
        angle: 'Angle ${index + 1}',
        status: index % 2 == 0 ? 'Active' : 'Inactive',
        AIAssessment: 'Assessment ${index + 1}',
        comments: 'Performance review ${index + 1}',
        availability: index % 2 == 0 ? 'Available' : 'Unavailable',
        expertNetworkName: 'Network ${index % 3 + 1}',
        cost: (index + 1) * 100.0,
        screeningQuestions: [
          'What is your background in ${index % 3 + 1}?',
          'How do you handle stress?',
          'What are your key achievements?'
        ],
        addedExpertBy: 'Admin${index % 2 + 1}',
        dateAddedExpert: DateTime.now().subtract(Duration(days: index * 10)),
        addedCallBy: 'Caller${index + 1}',
        dateAddedCall: DateTime.now().subtract(Duration(days: index * 5)),
        meetingStartDate: DateTime.now().add(Duration(days: index * 2)),
        meetingEndDate: DateTime.now().add(Duration(days: index * 2 + 1)),
        paidStatus: index % 2 == 0,
        rating: index % 5 + 1);
  });

  static User user1 = User(
    userId: "001",
    email: "john.doe@example.com",
    fullName: "John Doe",
    password: "password123",
    organizationId: "org001",
    projectId: "proj001",
    dateOnboarded: DateTime.parse("2022-01-01"),
    pastProjectIDs: ["proj001", "proj002"],
    admin: true,
    signedAt: DateTime.now(),
    token: "token_001",
  );

  static User user2 = User(
    userId: "002",
    email: "jane.smith@example.com",
    fullName: "Jane Smith",
    password: "securePassword321",
    organizationId: "org002",
    projectId: "proj002",
    dateOnboarded: DateTime.parse("2023-05-01"),
    pastProjectIDs: ["proj003", "proj004"],
    admin: false,
    signedAt: DateTime.now(),
    token: "token_002",
  );

  static User user3 = User(
    userId: "003",
    email: "alice.jones@example.com",
    fullName: "Alice Jones",
    password: "alicePassword789",
    organizationId: "org003",
    projectId: "proj005",
    dateOnboarded: DateTime.parse("2024-01-01"),
    pastProjectIDs: ["proj006"],
    admin: false,
    signedAt: DateTime.now(),
    token: "token_003",
  );

  static List<User> all_users = [user1, user2, user3, sampleUser];
  static List<Project> sampleProjects = [
    Project(
        projectId: "001",
        name: "Climate Action",
        startDate: DateTime(2024, 5, 10),
        endDate: DateTime(2024, 12, 15),
        organizationId: "NGO12345",
        target: "Reduce emissions by 10%",
        callsCompleted: 150,
        status: "Active"),
    Project(
        projectId: "002",
        name: "Reforestation Project",
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 6, 30),
        organizationId: "GREEN2040",
        target: "Plant 20,000 trees",
        callsCompleted: 20000,
        status: "Completed"),
    Project(
        projectId: "003",
        name: "Beach Cleanup",
        startDate: DateTime(2024, 4, 22),
        organizationId: "CLEANSEA",
        target: "Collect 5 tons of waste",
        callsCompleted: 500,
        status: "In Progress"),
    Project(
        projectId: "004",
        name: "Innovative Education",
        startDate: DateTime(2024, 3, 12),
        organizationId: "EDU100",
        target: "Educate 1000 students",
        callsCompleted: 1000,
        status: "Planning"),
    Project(
        projectId: "005",
        name: "Water Accessibility",
        startDate: DateTime(2024, 9, 1),
        organizationId: "WATERLIFE",
        target: "Install 50 water pumps",
        callsCompleted: 25,
        status: "Active")
  ];
}
