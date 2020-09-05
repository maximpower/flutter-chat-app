import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();


  List<ChatMessage> _messages = [
  ];

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3.0),
            Text('Natalia Skvarylo', style: TextStyle(color:  Colors.black87, fontSize: 12)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                reverse:  true,
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: ( _ ,i ) => _messages.elementAt(i),
              ),
            ),
            Divider( height: 1),
            //TODO: Caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
   );
  }

  _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0 ),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (text){
                  //TODO: cuando hay un valor, para poder postear
                  setState(() {
                    if(text.trim().length >0){ 
                      _isTyping = true;
                    }else{
                      _isTyping = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Send Message'
                ),
                focusNode: _focusNode,
              ),
            ),

            //Botón de enviar
            Container(
              margin:EdgeInsets.symmetric( horizontal: 4.0 ),
              child: !Platform.isIOS 
              ?  CupertinoButton(
                child: Text('Send'), 
                onPressed: _isTyping
                    ? ()=> _handleSubmit(_textController.text.trim())
                    : null
              )
              :  Container(
                margin: EdgeInsets.symmetric( horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send ),
                    onPressed: _isTyping
                    ? ()=> _handleSubmit(_textController.text.trim())
                    : null
                  ),
                ),
              )
            )

          ],
        ),

      ),
    );
  }

  _handleSubmit(String texto){
    print(texto);
    if(texto.trim().length == 0){
      return;
    }
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123', 
      text: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0,newMessage);
    newMessage.animationController.forward();
    
    setState(() {
      _isTyping = false;
    });

  }

  @override
  void dispose() {
    //TODO: Off del socket.
    for( ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}