bool? nullExtensions;

extension IntNullExtension on int? {
  int nonNullValue([defaultValue = 0]) {
    return this ?? defaultValue;
  }
}

extension StringNullExtension on String? {
  String nonNullValue([defaultValue = '']) {
    return this ?? defaultValue;
  }

  String nonNullValueEmpty(String defaultValue) {
    if (this == null) return defaultValue;
    if (this!.trim().isEmpty) return defaultValue;
    return this!;
  }
}

extension NumNullExtensions on num? {
  num nonNullValue([defaultValue = 0.0]) {
    return this ?? defaultValue;
  }
}

extension DoubleNullExtensions on double? {
  double nonNullValue([defaultValue = 0.0]) {
    return this ?? defaultValue;
  }
}

extension BoolNullExtension on bool? {
  bool nonNullValue([defaultValue = false]) {
    return this ?? defaultValue;
  }
}

extension ListExts on List {
  dynamic get firstOrNull {
    if (isEmpty) return null;
    return first;
  }
  dynamic get firstOrNull2 {
    if (isEmpty) return null;
    return first;
  }
}

extension SwappableList<T> on List<T> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}