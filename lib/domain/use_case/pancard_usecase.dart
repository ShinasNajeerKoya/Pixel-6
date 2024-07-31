import 'package:pixel6_test/data/models/pan_details_model.dart';
import 'package:pixel6_test/domain/repository/pancard_repository.dart';

class PanCardDetailsUseCase {
  final PanCardRepository panCardRepository;

  PanCardDetailsUseCase({required this.panCardRepository});

  Future<PanDetailsModel?> fetchPostCodeDetails(String panNumber) async {
    return panCardRepository.fetchPan(panNumber);
  }
}
