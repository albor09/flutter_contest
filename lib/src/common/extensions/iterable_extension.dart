extension IterableExtension on Iterable {
  Iterable<K> separate<K, T extends K>(T separator) {
    return Iterable.generate(length * 2 - 1,
        (index) => index % 2 == 0 ? separator : elementAt(index - index ~/ 2));
  }
}
