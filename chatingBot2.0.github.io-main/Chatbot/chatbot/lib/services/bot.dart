import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Bot {
  late String botReply;

  Future<void> getChatbotReply(String userReply) async {
    Response response = await get(Uri.parse(
        "http://api.brainshop.ai/get?bid=167717&key=kMGlgNWRTqD99OIY&uid=uid&msg=$userReply"));
    Map data = jsonDecode(response.body);
    botReply = data["cnt"];
    print(botReply);

    //return botReply;
  }
}
