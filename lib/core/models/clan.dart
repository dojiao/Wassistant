import '../mixins/date_helper.dart';

/// Player model
class Clan with DateHelper {
  /// Clan id
  int clanId;

  /// Clan creation date
  DateTime createdAt;

  /// Number of clan members
  int membersCount;

  /// Clan name
  String name;

  /// Clan tag
  String tag;

  /// Constructor
  Clan(
    this.clanId,
    this.createdAt,
    this.membersCount,
    this.name,
    this.tag,
  );

  /// Constructor

  /// Serializing JSON inside clan model
  Clan.fromJSON(Map<String, dynamic> json) {
    clanId = json['clan_id'];
    createdAt = dateTimeFromSeconds(json['created_at']);
    membersCount = json['members_count'];
    name = json['name'];
    tag = json['tag'];
  }

  /// Mapping clan model to JSON
  Map<String, dynamic> toJson() => {
        'clan_id': clanId,
        'created_at': createdAt,
        'account_id': membersCount,
        'name': name,
        'tag': tag,
      };
}
