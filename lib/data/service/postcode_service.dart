import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

class PostcodeService {
  Future<http.Response> fetchPostcodeDetails(String postCode) async {
    const url = 'https://lab.pixel6.co/api/get-postcode-details.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'postcode': postCode,
        }),
      );

      return response;
    } on SocketException catch (socketError) {
      throw Exception('No Internet connection: ${socketError.message}');
    } on http.ClientException catch (clientException) {
      throw Exception('Failed to connect to the server: ${clientException.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
