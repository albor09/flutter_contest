import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Corporative `TabBar` wiget
class CTabBar extends StatelessWidget {
  const CTabBar(
      {required this.tabs, this.index = 0, required this.onTap, super.key});

  final int index;
  final List<CTabItem> tabs;

  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: tabs.indexed
            .map(
              (item) => GestureDetector(
                onTap: () => onTap(item.$1),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
                  decoration: BoxDecoration(
                      color:
                          item.$1 == index ? primary : const Color(0xFFF2F2F2),
                      borderRadius: BorderRadiusDirectional.circular(16)),
                  child: Row(
                    children: [
                      item.$2.iconUrl != null
                          ? SvgPicture.asset(
                              item.$2.iconUrl!,
                              color: item.$1 == index
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFBCBCBF),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        item.$2.title,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: item.$1 == index
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFFBCBCBF)),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CTabItem {
  const CTabItem({required this.title, this.iconUrl});

  final String title;
  final String? iconUrl;
}
