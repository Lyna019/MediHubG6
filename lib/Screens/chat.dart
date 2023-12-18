

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ChatScreen extends StatefulWidget {
  final String receiverName;

  final String? initialMessage;

  ChatScreen({required this.receiverName, this.initialMessage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message('Hello!', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 5)),senderName:'Ahmed'),
    Message('Hi there!', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 3)),senderName: 'Mohammed'),
    Message('How are you?', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 2)),senderName: 'Mustapha'),
  ];
  @override
  void initState() {
    super.initState();

    // Add the initial message to the chat if available
    if (widget.initialMessage != null) {
      _sendMessage(widget.initialMessage!);
    }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(width: 70.0),
            Center(
              child: Text(
                widget.receiverName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 120.0),
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                // Add your phone icon onPressed logic here
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageTile(_messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageTile(Message message) {
    return Container(
      alignment: message.isSent ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: message.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: message.isSent ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message.text,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            _formatTimestamp(message.timestamp),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage([String? text]) {
  if (text == null) {
    text = _messageController.text.trim();
  }

  if (text.isNotEmpty) {
    setState(() {
      DateTime now = DateTime.now();
      Message message = Message(text!, isSent: true, timestamp: now);
      _messages.add(message);
      _messageController.clear();
      _simulateSending(message);
    });
  }
}

  Future<void> _simulateSending(Message message) async {
    // Simulate a delay before showing the checkmark icon
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      message.isSending = false;
    });
  }

  String _formatTimestamp(DateTime timestamp) {
    // Convert to Algeria timezone
    timestamp = timestamp.toLocal().add(Duration(hours: 1)); // Add 1 hour for Algeria timezone
    return DateFormat('HH:mm', 'en_US').format(timestamp);
  }
}

class Message {
  final String text;
  final DateTime timestamp;
  final bool isSent;
  bool isSending;
  String senderName; // Change from SenderName to senderName

  Message(this.text, {required this.isSent, required this.timestamp, this.isSending = true, this.senderName = ''});
}


class CircleIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;

  const CircleIconButton({
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: CircleBorder(),
      ),
      child: Container(
        padding: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}