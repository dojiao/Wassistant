import '../constants/keys.secret.dart';
import '../enums/api_type.dart';
import '../mixins/http_helper.dart';
import '../models/clan.dart';
import 'api_wrapper.dart';

/// Player service for networking requests
class ClanService with HttpHelper {
  /// Instance of api wrapper
  final _apiWrapper = ApiWrapper(ApiType.clan);

  /// Returns a paginated list of clan by search query and page no
  Future<List<Clan>> fetchClans(String search, int pageNo) async {
    var clans = <Clan>[];
    // fetch clans
    var response = await _apiWrapper.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'search': search,
        'limit': 30,
        'page_no': pageNo,
      },
    );

    // convert response to json object with validations
    final json = mappingWithValidation(response);

    // loop and convert each item to clan model
    List<dynamic> parsedList = json['data'];
    for (final clan in parsedList) {
      clans.add(Clan.fromJSON(clan));
    }
    return clans;
  }
}
