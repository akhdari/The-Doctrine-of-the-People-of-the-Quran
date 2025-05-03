import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import '../models/get/typehead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as dev;
import 'error_illustration.dart';

const String typeheadUrl = "http://192.168.100.20/phpscript/typehead.php";
Future<List<Typehead>> getSessions(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    final typeheads = jsonResponse
        .map((item) => Typehead.fromJson(item as Map<String, dynamic>))
        .toList();
    return typeheads;
  } else {
    throw Exception('Failed to load lectures');
  }
}

class SearchFeild extends StatefulWidget {
  final void Function(int) selectedSession;
  const SearchFeild({super.key, required this.selectedSession});

  @override
  State<SearchFeild> createState() => _SearchFeildState();
}

class _SearchFeildState extends State<SearchFeild> {
  int? selectedSession;
  late TextEditingController textController;
  late ScrollController scrollController;
  late SuggestionsController<Typehead>? suggestionsController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    scrollController = ScrollController();
    suggestionsController = SuggestionsController<Typehead>();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Typehead>(
      controller: textController,
      scrollController: scrollController,
      suggestionsController: suggestionsController,
      hideOnEmpty: true,
      suggestionsCallback: (String pattern) async {
        return await getSessions(typeheadUrl);
      },
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'session name',
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  suggestionsController?.refresh();
                },
              ),
            ));
      },
      itemBuilder: (context, lecture) {
        return ListTile(
          title: Text(lecture.sessionNameAr),
        );
      },
      emptyBuilder: (context) => ErrorIllustration(
        illustrationPath: 'assets/illustration/empty-box.svg',
        title: 'No Sessions Found',
        message: 'Start typing to search for sessions',
      ),
      errorBuilder: (context, error) => ErrorIllustration(
        illustrationPath: 'assets/illustration/bad-connection.svg',
        title: 'Connection Error',
        message:
            'Failed to load sessions. Please check your internet connection.',
        onRetry: () {
          textController.clear();
          suggestionsController?.refresh();
        },
      ),
      onSelected: (session) {
        dev.log('id on selected: ${session.sessionId}');
        widget.selectedSession(session.sessionId);
        textController.text = session.sessionNameAr;
      },
    );
  }
}
