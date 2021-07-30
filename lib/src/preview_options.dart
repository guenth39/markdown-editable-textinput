import 'package:flutter/widgets.dart';

///Preview Options defines the way the preview is added to the Input
class PreviewOptions {
  /// The labels shown in the TabBar
  final String editorTabLabel, previewTabLabel;

  /// Builds the [Widget] shown in the Preview Tab
  ///
  /// As second value you will recive the current value of
  /// the TextField as [String]
  final ValueWidgetBuilder<String> previewBuilder;

  /// Creates new PreviewOptions
  ///
  /// With optional fields [previewTabLabel] and [editorTabLabel]
  /// you can define the Text shown in the TabBar.
  ///
  /// With the required field [previewBuilder] you can pass a
  /// buildfunction for the preview. That way its easy to reuse
  /// your widget to show Markdown with your custom options. The
  /// minimal approach is:
  /// ```dart
  /// previewBuilder: (context, value, _) =>
  ///   Markdown(
  ///     data: value,
  ///   ),
  /// ```
  PreviewOptions({
    this.previewTabLabel = 'Preview',
    this.editorTabLabel = 'Editor',
    required this.previewBuilder,
  });
}
