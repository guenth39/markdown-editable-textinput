extension StringExtension on String {
  String insert(String string, [int? position]) {
    if (position == null) {
      return this + string;
    }
    final befor = this.substring(0, position - 1);
    final after = this.substring(position - 1);
    return befor + string + after;
  }
}
