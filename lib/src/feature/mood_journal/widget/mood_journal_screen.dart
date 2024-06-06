import 'package:flutter/material.dart';
import 'package:flutter_contest/src/common/extensions/date_time_extension.dart';
import 'package:flutter_contest/src/common/widgets/box_shadow.dart';
import 'package:flutter_contest/src/common/widgets/slider.dart';
import 'package:flutter_contest/src/common/widgets/tab_bar.dart';
import 'package:flutter_contest/src/common/widgets/unfocus.dart';
import 'package:flutter_contest/src/feature/mood_journal/model/mood.dart';
import 'package:flutter_contest/src/feature/mood_journal/widget/mood_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoodJournalScreen extends StatefulWidget {
  const MoodJournalScreen({super.key});

  @override
  State<MoodJournalScreen> createState() => _MoodJournalScreenState();
}

class _MoodJournalScreenState extends State<MoodJournalScreen> {
  int _tabIndex = 0;
  int _moodIndex = -1;
  int _subMoodIndex = -1;

  double _stressValue = 0;
  double _selfRatingValue = 0;

  final TextEditingController _noteController = TextEditingController();

  bool _stressTouched = false;
  bool _selfRatingTouched = false;

  bool isValid = false;

  void checkIsValid() {
    if (_moodIndex != -1 &&
        _subMoodIndex != -1 &&
        _stressTouched &&
        _selfRatingTouched &&
        _noteController.text.trim().isNotEmpty != isValid) {
      setState(() {
        isValid = !isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(DateTime.now().dMMMMhmm()),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset('assets/icons/calendar.svg'),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(36),
              child: CTabBar(
                onTap: (index) => setState(() {
                  _tabIndex = index;
                }),
                index: _tabIndex,
                tabs: const [
                  CTabItem(
                    title: 'Дневник настроения',
                    iconUrl: 'assets/icons/book.svg',
                  ),
                  CTabItem(
                      title: 'Статистика', iconUrl: 'assets/icons/stat.svg')
                ],
              ))),
      body: Unfocus(
        child: SafeArea(
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _tabIndex == 0
                    ? ListView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        children: [
                          const _Title(text: 'Что чувствуешь?'),
                          const SizedBox(height: 8),
                          MoodList(
                              index: _moodIndex,
                              onChange: (index) {
                                checkIsValid();
                                setState(() {
                                  _subMoodIndex = -1;
                                  _moodIndex = index;
                                });
                              }),
                          const SizedBox(height: 16),
                          _moodIndex != -1
                              ? Wrap(
                                  children: List.generate(
                                      mockMoods[_moodIndex].subMoods.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              checkIsValid();
                                              setState(() {
                                                _subMoodIndex = index;
                                              });
                                            },
                                            child: _SubMoodItem(
                                                mood: mockMoods[_moodIndex]
                                                    .subMoods[index],
                                                isSelected:
                                                    _subMoodIndex == index),
                                          )))
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          const _Title(text: 'Уровень стресса'),
                          const SizedBox(height: 16),
                          StatefulBuilder(builder: (context, builder) {
                            return CSlider(
                                value: _stressValue,
                                anchors: const [1 / 5, 2 / 5, 3 / 5, 4 / 5],
                                onChange: (value) {
                                  checkIsValid();
                                  _stressTouched = true;
                                  builder(() {
                                    _stressValue = value;
                                  });
                                },
                                fromText: 'Низкий',
                                toText: 'Высокий');
                          }),
                          const SizedBox(height: 16),
                          const _Title(text: 'Самооценка'),
                          const SizedBox(height: 16),
                          StatefulBuilder(builder: (context, builder) {
                            return CSlider(
                                value: _selfRatingValue,
                                anchors: const [1 / 5, 2 / 5, 3 / 5, 4 / 5],
                                onChange: (value) {
                                  checkIsValid();
                                  _selfRatingTouched = true;
                                  builder(() {
                                    _selfRatingValue = value;
                                  });
                                },
                                fromText: 'Неуверенность',
                                toText: 'Уверенность');
                          }),
                          const SizedBox(height: 16),
                          const _Title(text: 'Заметки'),
                          const SizedBox(height: 16),
                          CBoxShadow(
                            child: TextField(
                                controller: _noteController,
                                onChanged: (value) => checkIsValid(),
                                maxLines: 3,
                                style:
                                    const TextStyle(color: Color(0xFF4C4C69)),
                                decoration: const InputDecoration(
                                  hintText: 'Введите заметку',
                                )),
                          )
                        ],
                      )
                    : const Center(
                        child: Text('Статистика'),
                      ))),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
            onPressed: isValid
                ? () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Запись добавлена в дневник'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Закрыть'))
                              ],
                            ));
                  }
                : null,
            child: const Text('Сохранить')),
      ),
      extendBody: true,
    );
  }
}

class _SubMoodItem extends StatelessWidget {
  const _SubMoodItem({required this.mood, this.isSelected = false, super.key});

  final String mood;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return CBoxShadow(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isSelected ? primary : Colors.white),
            child: Text(
              mood,
              style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF4C4C69)),
            )));
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Color(0xFF4C4C69), fontSize: 16, fontWeight: FontWeight.w800),
    );
  }
}
