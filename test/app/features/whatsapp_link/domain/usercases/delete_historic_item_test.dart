import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/delete_historic_item.dart';

import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late DeleteHistoricItem usercase;
  late MockWhatsappLinkRepository repository;
  final index = 1;

  setUp(() {
    repository = MockWhatsappLinkRepository();
    usercase = DeleteHistoricItem(repository);
  });

  test("must delete a specific item in the repository whatsapp link list",
      () async {
    //arrange
    when(repository.remove(index: index))
        .thenAnswer((_) async => const Right(true));
    //act
    final result = await repository.remove(index: index);
    //assert
    expect(result, equals(isA<Right>()));
    verify(repository.remove(index: index));
    verifyNoMoreInteractions(repository);
  });
}
