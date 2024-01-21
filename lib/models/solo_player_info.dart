class SoloPlayerInfo {
  int id;
  String ign;
  String name;
  String club;
  String clan;

  SoloPlayerInfo({required this.id, required this.ign, required this.name, required this.club, required this.clan});

  factory SoloPlayerInfo.fromMap(Map<String, dynamic> json) => SoloPlayerInfo(id: json["id"], ign: json["ign"], name: (json["name"]), club: json["club"], clan: json["clan"]);

  Map<String, dynamic> toMap() => {"id": id, "ign": ign, "name": name, "club": club, "clan": clan};
}
