import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/delete_historic_all.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late DeleteHistoricAll usercase;
  late WhatsappLinkRepository repository;

  setUp(() {
    repository = MockWhatsappLinkRepository();
    usercase = DeleteHistoricAll(repository);
  });

  test("should deleted all whatsapp link list from the repository", () async {
    //arrange
    when(repository.removeAll()).thenAnswer((_) async => const Right(true));
    //act
    var result = await usercase.call(NoParams());
    //assert
    expect(result, equals(isA<Right>()));
    verify(repository.removeAll());
    verifyNoMoreInteractions(repository);
  });
}
