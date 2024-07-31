import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixel6_test/data/models/postcode_details_model.dart';
import 'package:pixel6_test/data/service/postcode_service.dart';

class PostcodeDetailsRepository {
  final PostcodeService postcodeService;

  PostcodeDetailsRepository({required this.postcodeService});

  Future<PostcodeDetails?> fetchPostCodeDetails(String postCode) async {
    PostcodeDetails? postcodeDetails;
    final Response response = await postcodeService.fetchPostcodeDetails(postCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      postcodeDetails = PostcodeDetails.fromJson(data);
    }

    return postcodeDetails;
  }
}
