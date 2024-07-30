// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:http/http.dart' as http;
// import 'package:login_signup/data/models/movie_model.dart';
//
// class MovieAPI {
//   static Future<void> fetchMovieList(void Function(List<MovieModel>, String?) callback) async {
//     final url = Uri.parse('https://hoblist.com/api/movieList');
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode({"category": "movies", "language": "kannada", "genre": "all", "sort": "voting"});
//
//     try {
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         List<MovieModel> movies = [];
//
//         for (var item in jsonResponse['result']) {
//           movies.add(MovieModel.fromJson(item));
//         }
//
//         callback(movies, null); // on success
//       } else {
//         log('Request failed with status: ${response.statusCode}.');
//         callback([], 'Failed to fetch movies. Please try again later.');
//       }
//     } catch (error) {
//       log('Exception details: $error');
//       callback([], 'An error occurred. Please try again later.');
//     }
//   }
// }
