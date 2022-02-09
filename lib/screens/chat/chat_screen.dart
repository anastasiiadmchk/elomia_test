import 'package:bubble/bubble.dart';
import 'package:elomia_test/network/network.dart';
import 'package:elomia_test/screens/chat/widgets/reaction_button.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  bool _isBotTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ElomiaTheme.darkIndigo,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            color: ElomiaTheme.darkIndigo,
            child: Stack(children: [
              Image.asset(
                'assets/chat/chat_headder.png',
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Image.asset(
                    'assets/chat/secondary_btn.png',
                    width: 45,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [
            //   0.1,
            //   0.6,
            //   0.9,
            // ],
            colors: [
              ElomiaTheme.darkIndigo,
              ElomiaTheme.indigo,
              ElomiaTheme.blue,
            ],
          ),
        ),
        child: Chat(
          theme: DefaultChatTheme(
            backgroundColor: Colors.transparent,
            inputBackgroundColor: ElomiaTheme.milkWhite,
            inputBorderRadius: BorderRadius.circular(15),
            inputMargin: const EdgeInsets.all(10),
            inputPadding: const EdgeInsets.all(10),
            inputTextColor: ElomiaTheme.darkGrey,
            inputTextCursorColor: ElomiaTheme.grey,
            inputTextStyle: const TextStyle(fontWeight: FontWeight.w400),
          ),
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          bubbleBuilder: _bubbleBuilder,
        ),
      ),
    );
  }

  void _loadMessages() async {
    final messagesHistory = await Network.sharedInstance.getMessages();
    if (messagesHistory.success ?? false) {
      setState(() {
        _messages = messagesHistory.value!;
      });
    }
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: '9',
      text: message.text,
    );

    _addMessage(textMessage);
    if (!_isBotTyping) {
      _isBotTyping = true;
      Future.delayed(const Duration(milliseconds: 2000)).whenComplete(() =>
          _addMessage(const types.TextMessage(
              author: types.User(id: 'bot'), id: '10', text: '0')));
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) {
    
    bool messageWithReaction = _user.id != message.author.id &&
        (message.metadata?.containsKey('reaction') ?? false);

    bool hasReaction =
        messageWithReaction && message.metadata?['reaction'] != Reaction.notSet;

    bool needReaction =
        messageWithReaction && message.metadata?['reaction'] == Reaction.notSet;

    return (!(message.author.id != _user.id &&
            _messages.first == message &&
            _isBotTyping))
        ? Row(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
              flex: 3,
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: _user.id != message.author.id
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Bubble(
                        child: child,
                        nipOffset: 3.0,
                        color: _user.id != message.author.id
                            ? ElomiaTheme.darkWhite
                            : ElomiaTheme.purple,
                        padding: const BubbleEdges.symmetric(
                            horizontal: 0, vertical: 0),
                        margin: hasReaction
                            ? const BubbleEdges.only(bottom: 18, right: 8)
                            : const BubbleEdges.all(0),
                        nip: _user.id != message.author.id
                            ? BubbleNip.leftBottom
                            : BubbleNip.rightBottom,
                        radius: const Radius.circular(15.0),
                      ),
                      if (hasReaction)
                        Positioned(
                          right: 0,
                          child: ReactionButton(
                              reaction: message.metadata?['reaction'],
                              color:
                                  message.metadata?['reaction'] == Reaction.like
                                      ? ElomiaTheme.green
                                      : ElomiaTheme.red,
                              onPressed: () {
                                setState(() {
                                  message.metadata?['reaction'] =
                                      Reaction.notSet;
                                });
                                return null;
                              }),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (needReaction) ...unsetReactionWidget(message: message)
          ])
        : Align(
            alignment: Alignment.bottomLeft,
            child: TypingIndicator(
              showIndicator: _isBotTyping,
            ),
          );
  }

  unsetReactionWidget({required dynamic message}) {
    return [
      Expanded(
        flex: 1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ReactionButton(
                reaction: Reaction.like,
                color: message.metadata?['reaction'] == Reaction.like
                    ? ElomiaTheme.green
                    : ElomiaTheme.lightGrey,
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 300))
                      .whenComplete(() => setState(
                            () => message.metadata?['reaction'] = Reaction.like,
                          ));
                  return ElomiaTheme.green;
                }),
            const SizedBox(
              width: 10,
            ),
            ReactionButton(
                reaction: Reaction.dislike,
                color: message.metadata?['reaction'] == Reaction.dislike
                    ? ElomiaTheme.red
                    : ElomiaTheme.lightGrey,
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 300))
                      .whenComplete(() => setState(
                            () => message.metadata?['reaction'] =
                                Reaction.dislike,
                          ));
                  return ElomiaTheme.red;
                }),
          ],
        ),
      )
    ];
  }
}
