import 'package:flutter/material.dart';
import 'package:flutter_contest/src/feature/mood_journal/model/mood.dart';

class MoodList extends StatelessWidget {
  const MoodList({required int index, required this.onChange, super.key})
      : _index = index;

  final int _index;
  final void Function(int index) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: mockMoods.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if (_index == index) return;
                onChange(index);
              },
              child: _MoodItem(
                mood: mockMoods[index],
                isSelected: _index == index,
              ))),
    );
  }
}

class _MoodItem extends StatelessWidget {
  const _MoodItem({required this.mood, this.isSelected = false, super.key});

  final Mood mood;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(76),
          border: isSelected
              ? Border.all(color: const Color(0xFFFF8702), width: 2)
              : null,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(34, 182, 161, 192),
                offset: Offset(2, 4),
                blurRadius: 10)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
                width: 52,
                height: 52,
                child: Image.asset(
                  'assets/images/${mood.img}',
                  fit: BoxFit.fill,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              mood.name,
              style: const TextStyle(fontSize: 10, color: Color(0xFF4C4C69)),
            ),
          )
        ],
      ),
    );
  }
}
