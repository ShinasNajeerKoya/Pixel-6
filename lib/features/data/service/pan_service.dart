import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pixel6_test/features/data/models/pan_details_model.dart';

Future<PanDetailsModel?> verifyPan(String panNumber) async {
  const url = 'https://lab.pixel6.co/api/verify-pan.php';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'panNumber': panNumber}),
  );

  // checking the response
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return PanDetailsModel.fromJson(data);
  } else {
    return null;
  }
}
