import 'domain/sight.dart';

final mocks = [
  Sight(
      'Jazz Hotel',
      'https://jazzhotel.ru/',
      '''«Джаз отель» расположен в южном округе города Москвы, недалеко от станций метро «Варшавская» и «Каширская», откуда до центра города можно добраться за 20 минут. На расстоянии в 2,8 километра от гостиницы располагается музей-заповедник «Коломенское», в 6 километрах - парк «Царицыно».''',
      'отель',
      55.66,
      37.62,
      [mockImages[2], mockImages[0]],
      SightStatus.sightToVisit,
      1),
  Sight(
      'Kristal Hotel',
      'http://hkristal.ru/',
      '''Трехзвездочный отель «Кристалл» предлагает размещение в современных комфортабельных номерах по привлекательным ценам в центре Москвы, с индивидуальным сервисом для каждого гостя.''',
      'отель',
      55.68,
      37.57,
      [mockImages[3], mockImages[0]],
      SightStatus.sightToVisit,
      2),
  Sight(
      'Metropol Hotel',
      'https://metropol-moscow.ru/',
      '''«Метрополь» был задуман меценатом, владельцем первой в России частной оперы Саввой Мамонтовым, как «театр с гостиницей». К созданию проекта Мамонтов привлекает архитектора Вильяма Валькотта, художников Михаила Врубеля, Николая Андреева и многих других.
''',
      'отель',
      55.75,
      37.62,
      [mockImages[4], mockImages[0]],
      SightStatus.sightVisited,
      3),
  Sight(
      'Historical museum',
      'https://shm.ru/',
      '''О музее
Почти полтора столетия Красную площадь Москвы украшает величественное здание Исторического музея, построенное в 1875–1883 гг. специально для размещения национальной сокровищницы России. Своим появлением один из старейших московских музеев обязан грандиозной Всероссийской Политехнической выставке.   
    ''',
      'музей',
      55.75,
      37.62,
      [mockImages[5], mockImages[0]],
      SightStatus.sightNoPlans,
      4)
];

List<String> mockImages = [
  'lib/ui/res/images/marina_alimos.jpg',
  'lib/ui/res/images/marina_palma.jpg',
  'lib/ui/res/images/jazz.jpg',
  'lib/ui/res/images/kristal.jpg',
  'lib/ui/res/images/metropol.jpg',
  'lib/ui/res/images/historical_museum.jpg',
];
