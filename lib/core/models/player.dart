/// Player model
class Player {
  /// Player name
  String nickname;

  /// User id
  int accountId;

  /// Serializing JSON inside player model
  Player.fromJSON(Map<String, dynamic> json) {
    nickname = json['nickname'];
    accountId = json['account_id'];
  }

  /// Mapping player model to JSON
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'account_id': accountId,
      };
}
