import 'package:flutter/widgets.dart';

class FormatOptions {
  final List<FormatOption> options;

  FormatOptions({
    required this.options,
  });
}

class FormatOption {
  final Widget icon;
  final Function action;

  FormatOption({
    required this.icon,
    required this.action,
  });
}
