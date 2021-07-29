import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';

/// Widget with markdown buttons
class MarkdownTextInput extends StatefulWidget {
  /// Callback called when text changed
  final Function onTextChanged;

  /// Initial value you want to display
  final String initialValue;

  /// Validator for the TextFormField
  final String Function(String? value)? validators;

  /// String displayed at hintText in TextFormField
  @Deprecated('Use inputDecoration.hintText instead).')
  final String label;

  /// Change the text direction of the input (RTL / LTR)
  final TextDirection textDirection;

  /// The maximum of lines that can be display in the input
  final int maxLines;

  /// The Decoration that should be applied to the input
  final InputDecoration inputDecoration;

  /// Constructor for [MarkdownTextInput]
  MarkdownTextInput(
    this.onTextChanged,
    this.initialValue, {
    this.label = '',
    this.validators,
    this.textDirection = TextDirection.ltr,
    this.maxLines = 10,
    this.inputDecoration = const InputDecoration(),
  });

  @override
  _MarkdownTextInputState createState() => _MarkdownTextInputState();
}

class _MarkdownTextInputState extends State<MarkdownTextInput> {
  final _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  TextSelection textSelection = const TextSelection(baseOffset: 0, extentOffset: 0);

  void onTap(MarkdownType type, {int titleSize = 1}) {
    final basePosition = textSelection.baseOffset;
    var noTextSelected = (textSelection.baseOffset - textSelection.extentOffset) == 0;

    final result = FormatMarkdown.convertToMarkdown(
        type, _controller.text, textSelection.baseOffset, textSelection.extentOffset,
        titleSize: titleSize);

    _controller.value = _controller.value
        .copyWith(text: result.data, selection: TextSelection.collapsed(offset: basePosition + result.cursorIndex));

    if (noTextSelected) {
      _controller.selection = TextSelection.collapsed(offset: _controller.selection.end - result.replaceCursorIndex);
    }
  }

  @override
  void initState() {
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      if (_controller.selection.baseOffset != -1) textSelection = _controller.selection;
      widget.onTextChanged(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _inputDecoration = widget.inputDecoration..applyDefaults(Theme.of(context).inputDecorationTheme);
    return InputDecorator(
      decoration: _inputDecoration.copyWith(
        floatingLabelBehavior: (_inputDecoration.floatingLabelBehavior == FloatingLabelBehavior.auto ||
                    _inputDecoration.floatingLabelBehavior == null) &&
                !_focus.hasFocus
            ? FloatingLabelBehavior.never
            : null,
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            focusNode: _focus,
            textInputAction: TextInputAction.newline,
            maxLines: widget.maxLines,
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => widget.validators!(value),
            textDirection: widget.textDirection,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              enabled: _inputDecoration.enabled,
              alignLabelWithHint: _inputDecoration.alignLabelWithHint,
              labelText: _inputDecoration.floatingLabelBehavior == FloatingLabelBehavior.always
                  ? ''
                  : _inputDecoration.labelText,
              labelStyle: _inputDecoration.labelStyle,
              floatingLabelBehavior: (_inputDecoration.floatingLabelBehavior == FloatingLabelBehavior.auto ||
                      _inputDecoration.floatingLabelBehavior == null)
                  ? FloatingLabelBehavior.never
                  : _inputDecoration.floatingLabelBehavior,
              hintText: _inputDecoration.hintText ?? widget.label,
              hintMaxLines: _inputDecoration.hintMaxLines,
              hintTextDirection: _inputDecoration.hintTextDirection,
              hintStyle: _inputDecoration.hintStyle,
            ),
          ),
          Divider(
            height: 8,
          ),
          Row(
            children: [
              OptionButton(
                key: const Key('bold_button'),
                onPressed: () => onTap(MarkdownType.bold),
                enabled: _inputDecoration.enabled,
                child: Icon(
                  Icons.format_bold,
                ),
              ),
              OptionButton(
                key: const Key('italic_button'),
                onPressed: () => onTap(MarkdownType.italic),
                enabled: _inputDecoration.enabled,
                child: const Icon(
                  Icons.format_italic,
                ),
              ),
              for (int i = 1; i <= 3; i++)
                OptionButton(
                  key: Key('H${i}_button'),
                  onPressed: () => onTap(MarkdownType.title, titleSize: i),
                  enabled: _inputDecoration.enabled,
                  child: Text(
                    'H$i',
                    style: TextStyle(fontSize: (18 - i).toDouble(), fontWeight: FontWeight.w700),
                  ),
                ),
              OptionButton(
                key: const Key('link_button'),
                onPressed: () => onTap(MarkdownType.link),
                enabled: _inputDecoration.enabled,
                child: const Icon(
                  Icons.link,
                ),
              ),
              OptionButton(
                key: const Key('list_button'),
                onPressed: () => onTap(MarkdownType.list),
                enabled: _inputDecoration.enabled,
                child: const Icon(
                  Icons.list,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// OptionButton is used to diplay an format option
class OptionButton extends StatelessWidget {
  /// Creates an OptionButton
  ///
  /// An OptionButton is basically an [IconButton] with some special Layout
  const OptionButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.size = 44.0,
    this.enabled = true,
  }) : super(key: key);

  /// The Widget to display inside the button.
  ///
  /// This property must not be null.
  final Widget child;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  ///The Size of the Button
  final double size;

  /// If false the Button can not be pressed
  ///
  /// This property is true by default.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: RawMaterialButton(
        onPressed: enabled ? onPressed : null,
        child: child,
      ),
    );
  }
}
