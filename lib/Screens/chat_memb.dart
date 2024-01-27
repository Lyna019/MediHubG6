import 'package:flutter/material.dart';
import '../Screens/chat.dart';
import 'package:intl/intl.dart';

class Message {
  final String text;
  final DateTime timestamp;
  final bool isSent;
  bool isSending;
  final String senderName; // Change from SenderName to senderName

  Message(this.text, {required this.isSent, required this.timestamp, this.isSending = true, this.senderName = ''});
}

class ChatMembersScreen extends StatelessWidget {
  List<Message> _messages = [
    Message('Hello!', isSent: true, timestamp: DateTime.now().subtract(Duration(minutes: 5)), senderName: 'Mohammed'),
    Message('Hi there!', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 3)), senderName: 'Ahmed'),
    Message('How are you?', isSent: true, timestamp: DateTime.now().subtract(Duration(minutes: 2)), senderName: 'Mustapha'),
  ];

  // Function to get unique members from messages
  List<String> _getAllMembers() {
    Set<String> allMembers = Set<String>();
    for (Message message in _messages) {
      allMembers.add(message.senderName);
    }
    return allMembers.toList();
  }

  bool _isMemberOnline(String memberName) {
    // Implement your logic to check if the member is online
    // For simplicity, let's assume they are online if they have sent a message in the last 5 minutes
    DateTime now = DateTime.now();
    DateTime lastMessageTimestamp = _messages
        .where((message) => message.senderName == memberName)
        .map((message) => message.timestamp)
        .fold(DateTime(2000), (prev, curr) => curr.isAfter(prev) ? curr : prev);

    return now.difference(lastMessageTimestamp).inMinutes <= 5;
  }

  Widget _buildOnlineMembers(List<String> onlineMembers) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: onlineMembers.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to the chat page with the receiver's name
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(receiverName: onlineMembers[index]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      // Assuming you have an online status property in Message class
                      backgroundImage: AssetImage('assets/images/profile1.jpg'),
                      child: Text(onlineMembers[index][0]), // Display the first letter of the name
                    ),
                    Positioned(
                      top: 2,
                      left: 2,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: _isMemberOnline(onlineMembers[index]) ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(onlineMembers[index]),
              ],
            ),
          ),
        );
      },
    );
  }

 Widget _buildChatMemberTile(BuildContext context, String memberName, List<Message> messages) {
  // Assuming Message class has properties: text and timestamp

  // Find the last message for the current member
  Message lastMessage = messages.firstWhere(
    (message) => message.senderName == memberName,
    orElse: () => Message( 'no message',isSent: false, timestamp: DateTime.now(), senderName: memberName),
  );

  return ListTile(
    title: Text(memberName),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lastMessage.text,
          style: TextStyle(fontSize: 14.0),
        ),
        Text(
          _formatTimestamp(lastMessage.timestamp), // Format timestamp accordingly
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
      ],
    ),
    leading: Stack(
      alignment: Alignment.topLeft,
      children: [
        CircleAvatar(
          radius: 30,
          // Assuming you have an online status property in Message class
          backgroundImage: AssetImage('assets/images/profile1.jpg'),
          child: Text(memberName[0]), // Display the first letter of the name
        ),
        Positioned(
          top: 2,
          left: 2,
          child: CircleAvatar(
            radius: 6,
            backgroundColor: _isMemberOnline(memberName) ? Colors.green : Colors.grey,
          ),
        ),
      ],
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(receiverName: memberName),
        ),
      );
    },
  );
}
String _formatTimestamp(DateTime timestamp) {
    // Convert to Algeria timezone
    timestamp = timestamp.toLocal().add(Duration(hours: 1)); // Add 1 hour for Algeria timezone
    return DateFormat('HH:mm', 'en_US').format(timestamp);
  }


  @override
  Widget build(BuildContext context) {
    List<String> allMembers = _getAllMembers();
    List<String> onlineMembers = allMembers.where(_isMemberOnline).toList();

    List<Message> messages = [
    Message('Hello!', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 5)), senderName: 'Mohammed'),
    Message('Hi there!', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 3)), senderName: 'Ahmed'),
    Message('How are you?', isSent: false, timestamp: DateTime.now().subtract(Duration(minutes: 2)), senderName: 'Mustapha'),
  ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Center(
              child: Text(
                'Chat Members',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80.0,
            child: _buildOnlineMembers(onlineMembers),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: allMembers.length,
              itemBuilder: (context, index) {
                return _buildChatMemberTile(context, allMembers[index], messages);

              },
            ),
          ),
        ],
      ),
    );
  }
}



