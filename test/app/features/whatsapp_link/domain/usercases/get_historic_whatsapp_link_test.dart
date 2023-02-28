import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_historic_whatsapp_link.dart';
import '../../../../../helpers/test_helpers.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late GetHistoricWhatsAppLink usercase;
  late MockWhatsappLinkRepository repository;
  List<LinkHistoric> historics = [];

  setUp(() {
    repository = MockWhatsappLinkRepository();
    usercase = GetHistoricWhatsAppLink(repository);
  });

  void convertedJsonToListModel() {
    final data = json.decode(fixture("whatsapp_link.json"));
    historics = (data as List).map((v) => LinkHistoricModel.fromJson(v)).toList();
  }

  test('should get whatsapp link list from the repository', () async {
    //arrange
    convertedJsonToListModel();
    when(repository.getHistoric()).thenAnswer((_) async => Right(historics));
    //act
    var result = await usercase(NoParams());
    //assert
    expect(result, equals(isA<Right>()));
    verify(repository.getHistoric());
    verifyNoMoreInteractions(repository);
  });
}
