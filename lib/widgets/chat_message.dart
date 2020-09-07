import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.text,
    @required this.uid,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.elasticOut),
        child: Container(
            child: this.uid == '123' ? _myMessage() : _notMyMessage()),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 10),
        child: Text(
          this.text,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xff4D9EF6)),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 50),
        child: Text(
          this.text,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xffE4E5E8)),
      ),
    );
  }
}
