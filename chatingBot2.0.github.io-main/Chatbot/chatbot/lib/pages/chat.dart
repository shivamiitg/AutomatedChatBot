import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/services/bot.dart';
import 'package:chatbot/services/chatbubble.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../services/chatbubble.dart';

List<ChatBubble> messages = [];

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String bot = "";

  void Endscroll() {
    final position = scrollController.position.maxScrollExtent + 500;

    scrollController.animateTo(position,
        duration: Duration(seconds: 1), curve: Curves.easeOut);
  }

  void BotReply(String userReply) async {
    Bot instance = Bot();
    await instance.getChatbotReply(userReply);

    bot = instance.botReply;

    setState(() {
      ChatBubble msg = ChatBubble(messageContent: bot, messageType: "receiver");
      messages.add(msg);
    });

    Endscroll();
  }

  @override
  void initState() {
    super.initState();

    //BotReply('Hi');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 15, 103, 175),
      child: Container(
        child: Scaffold(
            // backgroundColor: Color.fromARGB(255, 54, 133, 167),

            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 67, 154, 158),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 224, 215, 215),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  //messages.clear();
                },
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/bot.png'),
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    'SirBot',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      fontFamily: 'PoorStory-Regular',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              leadingWidth: 30.0,
            ),
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/chatbg3.jpg"), fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        "Today, ${DateFormat('Hm').format(DateTime.now())}",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white),
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Stack(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              //controller: scrollController,
                              shrinkWrap: true,
                              itemCount: messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin:
                                      messages[index].messageType == "receiver"
                                          ? EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 0.0)
                                          : EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 0.0),
                                  child: messages[index].messageType ==
                                          "receiver"
                                      ? BubbleSpecialOne(
                                          text: messages[index].messageContent,
                                          textStyle: TextStyle(

                                            fontSize: 25.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          isSender: false,
                                          color: Color.fromARGB(
                                              255, 167, 255, 249),
                                        )
                                      : BubbleSpecialOne(
                                          text: messages[index].messageContent,
                                          textStyle: TextStyle(

                                            fontSize: 25.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          isSender: true,
                                          color: Color.fromARGB(
                                              255, 255, 192, 109),
                                          seen: true,
                                        ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: Endscroll,
                            controller: textController,
                            maxLines: null,
                            decoration: InputDecoration(
                              suffixIcon: Container(
                                height: 40.0,
                                width: 40.0,
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 12.0, 5.0),
                                child: FloatingActionButton(
                                  onPressed: () {
                                    if (textController.text.isNotEmpty) {
                                      setState(() {
                                        messages.add(ChatBubble(
                                            messageContent: textController.text,
                                            messageType: "sender"));
                                      });

                                      BotReply(textController.text);
                                      Endscroll();

                                      textController.clear();
                                    }
                                  },
                                  splashColor: Color.fromARGB(255, 67, 154, 158),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 10.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 128, 124, 124)),
                              hintText: 'Ask me anything...',
                            ),
                            cursorColor: Colors.cyan,
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                               ),
                            enabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
