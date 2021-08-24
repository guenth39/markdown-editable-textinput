import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/markdown_editable_textinput.dart';

void main() => runApp(MyApp());

// ignore: public_member_api_docs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String description = 'My great package';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData(
          primaryColor: const Color(0xFF2C1C6B),
          accentColor: const Color(0xFF039BE5),
          textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 20)),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF8F9FC),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffd32f2f),
                width: 1.0,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff000000),
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF2C1C6B),
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: const Color(0xFF2C1C6B),
            unselectedLabelColor: Color(0xff000000),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: const Color(0xFF2C1C6B),
              ),
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('EditableTextInput'),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 400,
                          child: MarkdownTextInput(
                            initialValue: description,
                            controller: _controller,
                            onTextChanged: (String value) =>
                                setState(() => description = value),
                            inputDecoration: InputDecoration(
                              hintText: 'What to type here?',
                              labelText: 'Nice Label',
                              helperText: 'Some Helper text',
                            ),
                            validator: (text) =>
                                text != null && text.length > 20
                                    ? 'Text to Long!'
                                    : null,
                            previewOptions: PreviewOptions(
                              editorTabLabel: 'MyCustomEditorLabel',
                              previewBuilder: (context, value, child) =>
                                  Markdown(
                                data: value,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MarkdownBody(
                          data: description,
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
