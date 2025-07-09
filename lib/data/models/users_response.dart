class UsersResponse {
  final int id;
  final String description;
  final double latitude;
  final double longitude;
  final bool isFavorite;
  final bool enableAlert;
  final String photoUrl;
  final String date;
  final String locationDescription;

  UsersResponse({
    required this.id,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isFavorite,
    required this.enableAlert,
    required this.photoUrl,
    required this.date,
    required this.locationDescription,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      id: json["id"],
      description: json["description"],
      latitude: json["coordinates"]["latitude"],
      longitude: json["coordinates"]["longitude"],
      isFavorite: json["is_favorite"],
      enableAlert: json["enable_alert"],
      photoUrl: json["photo_url"],
      date: json["date"],
      locationDescription: json["location_description"],
    );
  }
}
