class DuoInfo {
  final int id;
  final String name;
  final String club;
  final String clan;
  final String side;
  final String score;
  final String point;
  final String leaderIGN;

  DuoInfo({required this.side, required this.score, required this.point, required this.leaderIGN, required this.id, required this.name, required this.club, required this.clan});

  factory DuoInfo.fromMap(Map<String, dynamic> json) => DuoInfo(
        id: json["id"],
        name: json["name"],
        club: json["club"],
        clan: json["clan"],
        side: json["side"],
        score: json["score"],
        point: json["point"],
        leaderIGN: json["leaderIGN"],
      );

  Map<String, dynamic> toMap() => {"id": id, "name": name, "club": club, "clan": clan, "side": side, "score": score, "point": point, "leaderIGN": leaderIGN};
}
