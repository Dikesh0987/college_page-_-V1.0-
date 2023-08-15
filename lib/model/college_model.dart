class CollegeModel {
  final String campusTour;
  final String collegeName;
  final String district;
  final String domain;
  final String logo;
  final String state;
  final String websiteLink;
  final String collegeUniqueId;

  CollegeModel({
    required this.campusTour,
    required this.collegeName,
    required this.district,
    required this.domain,
    required this.logo,
    required this.state,
    required this.websiteLink,
    required this.collegeUniqueId,
  });

  // Create a factory method to parse data from JSON map
  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      campusTour: json['campus_tour'] ?? "",
      collegeName: json['college_name'] ?? "",
      district: json['district'] ?? "",
      domain: json['domain'] ?? "",
      logo: json['logo'] ?? "",
      state: json['state'] ?? "",
      websiteLink: json['website_link'] ?? "",
      collegeUniqueId: json['collegeunique_id'] ?? "",
    );
  }

  // Convert the model instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'campus_tour': campusTour,
      'college_name': collegeName,
      'district': district,
      'domain': domain,
      'logo': logo,
      'state': state,
      'website_link': websiteLink,
      'collegeunique_id': collegeUniqueId,
    };
  }
}
