import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_historic_whatsapp_link.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late GetHistoricWhatsAppLink usercase;
  late MockWhatsappLinkRepository repository;
  late LinkHistoric linkHistoric;

  setUp(() {
    repository = MockWhatsappLinkRepository();
    usercase = GetHistoricWhatsAppLink(repository);
    linkHistoric = LinkHistoric(
        url: "https://wa.me/phone=5588992945488&text=teste",
        createdAt: DateTime.now());
  });

  test('should get whatsapp link list from the repository', () async {
    //arrange
    when(repository.getHistoric())
        .thenAnswer((_) async => Right([linkHistoric]));
    //act
    var result = await usercase(NoParams());
    //assert
    expect(result, equals(isA<Right>()));
    verify(repository.getHistoric());
    verifyNoMoreInteractions(repository);
  });
}
