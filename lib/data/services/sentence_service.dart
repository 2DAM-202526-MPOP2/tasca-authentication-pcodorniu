import 'dart:convert';

import 'package:first_flutter/data/models/sentence.dart';
import 'package:http/http.dart' as http;

abstract class ISentenceService {
  Future<Sentence> getNext();
}

class SentenceService implements ISentenceService {
  var count = 0;
  @override
  Future<Sentence> getNext() async {
    count ++;
    var response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$count'),
    );

    await Future.delayed(Duration(milliseconds: 2000));
    if (response.statusCode == 200) {
      return Sentence.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load album');
    }

  }
}
