import 'dart:convert';

import 'package:http/http.dart' as http;

class PanCodeService {
  Future<http.Response?> verifyPan(String panNumber) async {
    const url = 'https://lab.pixel6.co/api/verify-pan.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'panNumber': panNumber}),
    );

    return response;
  }
}
