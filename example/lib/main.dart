import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

void main() => runApp(MyApp());

// ignore: public_member_api_docs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String description = '';

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
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF2C1C6B),
                width: 5.0,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MarkdownTextInput(
                              (String value) =>
                                  setState(() => description = value),
                              description,
                              maxLines: 8,
                              inputDecoration: InputDecoration(
                                hintText: 'What to type here?',
                                labelText: 'Nice Label',
                                helperText: 'Some Helper text',
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
