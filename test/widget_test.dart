// Testes de dados + i18n. O conteúdo vem de assets/frases/<lang>.json (carregado
// via VerseData.init). i18n é puro. O app completo roda no device.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mensagens_de_natal/data/verses.dart';
import 'package:mensagens_de_natal/l10n/strings.dart';
import 'package:mensagens_de_natal/shared/widgets/countdown_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await VerseData.init();
  });

  test('12 categorias; cada mensagem pertence a uma delas (pt)', () {
    expect(VerseData.categories.length, 12);
    final ids = VerseData.categories.map((c) => c.id).toSet();
    for (final v in VerseData.allFor('pt')) {
      expect(ids.contains(v.categoryId), isTrue);
    }
  });

  test('pelo menos 1200 mensagens por idioma (pt/en/es)', () {
    expect(VerseData.allFor('pt').length, greaterThanOrEqualTo(1200));
    expect(VerseData.allFor('en').length, greaterThanOrEqualTo(1200));
    expect(VerseData.allFor('es').length, greaterThanOrEqualTo(1200));
  });

  test('conteúdo pt/en/es paralelo (mesmo nº por categoria; ids estáveis)', () {
    for (final c in VerseData.categories) {
      final pt = VerseData.countFor('pt', c.id);
      expect(VerseData.countFor('en', c.id), pt, reason: c.id);
      expect(VerseData.countFor('es', c.id), pt, reason: c.id);
    }
  });

  test('byId resolve o mesmo slot em idiomas diferentes', () {
    final ptVerse = VerseData.allFor('pt').first;
    final enVerse = VerseData.byId('en', ptVerse.id);
    expect(enVerse, isNotNull);
    expect(enVerse!.id, ptVerse.id);
    expect(enVerse.text, isNot(ptVerse.text));
  });

  test('frase do dia determinística; idioma sem conteúdo cai no inglês', () {
    expect(VerseData.ofToday('pt').id, VerseData.ofToday('pt').id);
    expect(VerseData.hasContent('fr'), isFalse);
    expect(VerseData.allFor('fr').first.text, VerseData.allFor('en').first.text);
  });

  test('i18n: nome do app + categorias por idioma', () {
    const pt = T(Locale('pt'));
    const en = T(Locale('en'));
    const es = T(Locale('es'));
    expect(pt.appName, 'Mensagens de Natal e Ano Novo');
    expect(en.appName, 'Christmas & New Year Wishes');
    expect(es.appName, 'Mensajes de Navidad y Año Nuevo');
    expect(pt.catName('reveillon'), 'Réveillon');
    expect(en.catName('gratidao'), 'Gratitude');
    expect(es.catName('ano_novo'), 'Año Nuevo');
  });

  test('contagem regressiva: Natal 25/12 e Ano Novo 01/01', () {
    expect(CountdownCard.daysUntil(DateTime(2026, 12, 25), 12, 25), 0);
    expect(CountdownCard.daysUntil(DateTime(2026, 12, 24, 23), 12, 25), 1);
    expect(CountdownCard.daysUntil(DateTime(2026, 12, 26), 12, 25), 364);
    expect(CountdownCard.daysUntil(DateTime(2026, 12, 31), 1, 1), 1);
    expect(CountdownCard.daysUntil(DateTime(2026, 1, 1), 1, 1), 0);
    expect(CountdownCard.daysUntil(DateTime(2026, 11, 16), 12, 25), 39);
    expect(CountdownCard.daysUntil(DateTime(2026, 11, 16), 1, 1), 46);

    const pt = T(Locale('pt'));
    expect(pt.countdownDays(1), 'Falta 1 dia');
    expect(pt.countdownDays(39), 'Faltam 39 dias');
  });
}
