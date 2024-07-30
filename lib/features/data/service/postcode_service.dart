import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

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

    // checking the response here
    // if successful
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load address details');
    }
  } on SocketException catch (socketError) {
    // stumbled upon this error in release mode
    print('SocketException: $socketError');
    throw Exception('No Internet connection');
  } on http.ClientException catch (clientException) {
    print('ClientException: $clientException');
    throw Exception('Failed to connect to the server');
  } catch (e) {
    print('Other Exception: $e');
    throw Exception('An unexpected error occurred');
  }
}
