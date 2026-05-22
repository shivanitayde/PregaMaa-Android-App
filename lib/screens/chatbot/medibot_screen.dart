import 'package:flutter/material.dart';
import 'package:pregmaa/services/api_service.dart';

class MediBotScreen extends StatefulWidget {
  @override
  _MediBotScreenState createState() => _MediBotScreenState();
}

class _MediBotScreenState extends State<MediBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  final Map<String, dynamic> medicalKnowledge = {
    'headache': {
      'causes': ['Tension, dehydration, stress, migraine, sinus issues'],
      'advice': [
        'Rest in dark room',
        'Hydrate',
        'OTC pain relief',
        'Cold compress',
      ],
      'doctor': [
        'Sudden severe headache',
        'Vision changes',
        'Neurological symptoms',
      ],
    },
    'fatigue': {
      'causes': ['Poor sleep, anemia, thyroid issues'],
      'advice': ['Improve sleep', 'Balanced diet', 'Exercise'],
      'doctor': ['>2 weeks', 'Weight loss'],
    },
    'fever': {
      'causes': ['Infection, inflammation'],
      'advice': ['Hydrate', 'Rest'],
      'doctor': ['>103°F', '>3 days'],
    },
  };

  @override
  void initState() {
    super.initState();

    messages.add({
      "type": "bot",
      "text": "Hi! I'm MediBot 🤗\nI help with symptoms.\n⚠️ Not a doctor.",
    });
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({"type": "user", "text": text});
    });

    _controller.clear();

    Future.delayed(Duration(milliseconds: 600), () {
      respond(text.toLowerCase());
    });
  }

  void respond(String msg) async {
    if (isEmergency(msg)) {
      addBotMessage("🚨 Emergency! Please call a doctor immediately.");
      return;
    }

    // Local quick response
    for (var key in medicalKnowledge.keys) {
      if (msg.contains(key)) {
        var data = medicalKnowledge[key];

        addBotMessage(
          "${key.toUpperCase()}\n\n"
          "Causes: ${data['causes'].join(', ')}\n\n"
          "Tips:\n• ${data['advice'].join('\n• ')}\n\n"
          "⚠️ Doctor if:\n• ${data['doctor'].join('\n• ')}",
        );
        return;
      }
    }

    // AI fallback
    addBotMessage("Typing...");

    String reply = await AIService.getResponse(msg);

    setState(() {
      messages.removeLast();
    });

    addBotMessage(reply);
  }

  void addBotMessage(String text) {
    setState(() {
      messages.add({"type": "bot", "text": text});
    });
  }

  bool isEmergency(String msg) {
    return [
      'chest pain',
      'breathing',
      'unconscious',
      'seizure',
    ].any((e) => msg.contains(e));
  }

  Widget buildMessage(Map<String, String> msg) {
    bool isUser = msg["type"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isUser ? null : Border.all(color: Colors.blue.shade100),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Text(
          msg["text"]!,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget quickReply(String text) {
    return GestureDetector(
      onTap: () => sendMessage(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f7ff),
      appBar: AppBar(
        title: Text("🩺 MediBot"),
        centerTitle: true,
        flexibleSpace: Container(color: Colors.amber[100]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, i) => buildMessage(messages[i]),
            ),
          ),

          Wrap(
            children: [
              quickReply("Headache"),
              quickReply("Fatigue"),
              quickReply("Fever"),
              quickReply("Cough"),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "How are you feeling?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () => sendMessage(_controller.text),
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
          SizedBox(height: 55),
        ],
      ),
    );
  }
}
