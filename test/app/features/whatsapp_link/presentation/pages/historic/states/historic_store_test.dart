import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:value_listenable_test/value_listenable_test.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/states/historic_state.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/states/historic_store.dart';
import '../../../../../../../helpers/test_helpers.mocks.dart';
import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  late List<LinkHistoric> historics;
  late HistoricStore store;
  late MockGetHistoricWhatsAppLink mockGetHistoricWhatsAppLink;
  late MockDeleteHistoricAll mockDeleteHistoricAll;
  late MockDeleteHistoricItem mockDeleteHistoricItem;
  late MockConfirmationDialog mockConfirmationDialog;

  setUp(() {
    mockGetHistoricWhatsAppLink = MockGetHistoricWhatsAppLink();
    mockDeleteHistoricAll = MockDeleteHistoricAll();
    mockDeleteHistoricItem = MockDeleteHistoricItem();
    mockConfirmationDialog = MockConfirmationDialog();
    store = HistoricStore(
        getHistoricWhatsAppLink: mockGetHistoricWhatsAppLink,
        deleteHistoricAll: mockDeleteHistoricAll,
        deleteHistoricItem: mockDeleteHistoricItem,
        confirmationDialog: mockConfirmationDialog);

    historics = (json.decode(fixture("whatsapp_link.json")) as List)
        .map((e) => LinkHistoricModel.fromJson(e))
        .toList();
  });

  test('initialState should be Initial', () {
    //assert
    expect(store.value, isA<InitialHistoricState>());
  });

  group("getAll", () {
    test('should get list of historic from the user case', () async {
      //arrange
      when(mockGetHistoricWhatsAppLink(any))
          .thenAnswer((_) async => Right(historics));
      //act
      await store.getHistoric();
      //assert
      expect(store.value, isA<SuccessHistoricState>());
    });

    test('should emit [loading, success] when data is gotten success',
        () async {
      //arrange
      when(mockGetHistoricWhatsAppLink(any))
          .thenAnswer((_) async => Right(historics));
      //assert Later
      final expected = [
        isA<LoadingHistoricState>(),
        isA<SuccessHistoricState>(),
      ];
      expect(store, emitValues(expected));
      //act
      await store.getHistoric();
    });

    test('should emit [loading, error] when cache data fails', () async {
      //arrange
      when(mockGetHistoricWhatsAppLink(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert Later
      final expected = [
        isA<LoadingHistoricState>(),
        isA<ErrorHistoricState>(),
      ];
      expect(store, emitValues(expected));

      //act
      await store.getHistoric();
    });
  });

  group("deleteAll", () {
    test('should removed all list of historic from the user case', () async {
      //arrange
      when(mockConfirmationDialog.show())
          .thenAnswer((_) async => true);
      when(mockDeleteHistoricAll(any))
          .thenAnswer((_) async => const Right(true));
      //act
      await store.removeAll();
      //assert
      expect(store.value, isA<SuccessHistoricState>());
    });

    test("should call nothing if dialog returns false", () async {
      //arrange
      when(mockConfirmationDialog.show())
          .thenAnswer((_) async => false);
      when(mockDeleteHistoricAll(any))
          .thenAnswer((_) async => const Right(true));
      //act
      await store.removeAll();
      //assert
      verifyZeroInteractions(MockDeleteHistoricAll());
    });

    test('should throw error when data removal fails', () async {
      //arrange
      when(mockConfirmationDialog.show())
          .thenAnswer((_) async => true);
      when(mockDeleteHistoricAll(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert Later
      final expected = [
        isA<ErrorHistoricState>(),
      ];
      expect(store, emitValues(expected));
      //act
      await store.removeAll();
    });
  });
}
