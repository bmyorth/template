class AppVersionModel {
  String? id;
  String version;
  int build;
  DateTime? createdAt;
  bool? active;
  String? urlVersion;
  String? os;

  AppVersionModel({
    this.id,
    this.version = '',
    this.build = 1,
    this.createdAt,
    this.active,
    this.urlVersion,
    this.os,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      AppVersionModel(
        id: json["id"],
        version: json["version"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        active: json["active"],
        urlVersion: json["urlVersion"],
        os: json["os"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "createdAt": createdAt?.toIso8601String(),
        "active": active,
        "urlVersion": urlVersion,
      };

  @override
  String toString() {
    String buildString = '';
    if (build > 1) {
      buildString = '+$build';
    }
    return '$version$buildString';
  }
}
