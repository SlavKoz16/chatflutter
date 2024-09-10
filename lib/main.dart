import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
void main() {
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: _messageController.text,
          isSentByMe: true,
          timestamp: DateTime.now(),
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title: Row(
        children: [
          Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        SizedBox(width: 12.0,),
        Text('Чат',style: TextStyle(fontSize: 26),),
        ],),
        backgroundColor: Color(0xFFE5E5E5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){ Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
      child:Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black12, width: 2.0),
              ),
            ),
          ),
          Expanded(

            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(_messages[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFFD7D7D7),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Align(
        alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: message.isSentByMe ? Color(0xFFD8D8D8): Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(10.0),
      ),
          constraints: BoxConstraints(maxWidth: 200.0),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
        message.text,
        style: TextStyle(
          fontSize: 18.0,
          color: message.isSentByMe ? Color(0xFF414141) : Color(0xFF414141),
        ),
      ),
        ],
      ),
      ),
        SizedBox(height: 5.0,),
        Text(
          _formatTime(message.timestamp),
          style: TextStyle(
            fontSize: 12.0,
            color:Color(0xFF414141),
          ),
        )
          ],
      ),
        ),
    );
  }

}
String _formatTime(DateTime timestamp) {
  return DateFormat('HH:mm').format(timestamp);
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.timestamp});
}

