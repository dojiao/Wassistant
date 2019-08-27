import '../constants/keys.secret.dart';
import '../enums/api_type.dart';
import '../mixins/http_helper.dart';
import '../models/clan.dart';
import '../models/clan_detail.dart';
import 'api_wrapper.dart';

/// Player service for networking requests
class ClanService with HttpHelper {
  /// Instance of api wrapper
  final _apiWrapper = ApiWrapper(ApiType.clan);

  /// Returns a paginated list of clan by search query
  Future<List<Clan>> fetchClans(String search) async {
    final clans = <Clan>[];
    // fetch clans
    final response = await _apiWrapper.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'search': search,
      },
    );

    // convert response to json object with validations
    // TODO: Fix the bug caused by too short search length.
    // Try searching just one letter then there will be
    // an uncatched exception.
    // Anywhere using this method is waiting to be fixed.
    final json = mappingWithValidation(response);

    // loop and convert each item to clan model
    List<dynamic> parsedList = json['data'];
    for (final clan in parsedList) {
      clans.add(Clan.fromJSON(clan));
    }
    return clans;
  }

  /// Returns detailed clan information
  Future<ClanDetail> fetchClan(int clanId) async {
    // fetch clan detail
    final response = await _apiWrapper.get(
      '/info/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'clan_id': clanId,
        'extra': 'members',
        'fields': '-members_ids',
      },
    );

    // convert response to json object with validations
    final json = mappingWithValidation(response);

    // convert json object to clan detail model
    return ClanDetail.fromJSON(json);
  }
}
