const mockMoods = [
  Mood(name: 'Радость', img: 'Joy.png', subMoods: [
    'Возбуждение',
    'Восторг',
    "Игривость",
    "Очарование",
    "Осознанность",
    "Смелость",
  ]),
  Mood(
      name: 'Страх',
      img: 'Fear.png',
      subMoods: ['Тревога', 'Ужас', 'Испуг', 'Паника', 'Беспокойство']),
  Mood(
      name: 'Бешенство',
      img: 'Rage.png',
      subMoods: ['Ярость', 'Гнев', 'Озлобленность', 'Неистовство', 'Злость']),
  Mood(
      name: 'Грусть',
      img: 'Sadness.png',
      subMoods: ['Печаль', 'Тоска', 'Уныние', 'Разочарование', 'Сожаление']),
  Mood(name: 'Спокойствие', img: 'Calmness.png', subMoods: [
    'Умиротворение',
    'Расслабление',
    'Спокойствие',
    'Безмятежность',
    'Удовлетворение'
  ]),
  Mood(
      name: 'Сила',
      img: 'Power.png',
      subMoods: ['Мощь', 'Сила духа', 'Уверенность', 'Твердость', 'Воля']),
];

class Mood {
  const Mood({required this.name, required this.img, required this.subMoods});

  final String name;
  final String img;
  final List<String> subMoods;
}
