import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixel6_test/data/models/pan_details_model.dart';
import 'package:pixel6_test/data/service/pan_service.dart';

class PanCardRepository {
  final PanCodeService panCodeService;

  PanCardRepository({required this.panCodeService});

  Future<PanDetailsModel?> fetchPan(String panNumber) async {
    PanDetailsModel? panDetailsModel;

    final Response? response = await panCodeService.verifyPan(panNumber);

    if (response?.statusCode == 200 && response?.body != null) {
      final data = jsonDecode(response!.body);
      panDetailsModel = PanDetailsModel.fromJson(data);
    }

    return panDetailsModel;
  }
}
