import 'package:pixel6_test/data/models/postcode_details_model.dart';
import 'package:pixel6_test/domain/repository/postcode_details_repository.dart';

class PostCodeDetailsUseCase {
  final PostcodeDetailsRepository postcodeDetailsRepository;

  PostCodeDetailsUseCase({required this.postcodeDetailsRepository});

  Future<PostcodeDetails?> fetchPostCodeDetails(String postCode) async {
    return postcodeDetailsRepository.fetchPostCodeDetails(postCode);
  }
}
