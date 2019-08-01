import '../mixins/date_helper.dart';

/// Clan model
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

  /// Serializing JSON inside clan model
  Clan.fromJSON(Map<String, dynamic> json) {
    clanId = json['clan_id'];
    createdAt = dateTimeFromSeconds(json['created_at']);
    membersCount = json['members_count'];
    name = json['name'];
    tag = json['tag'];
  }
}
