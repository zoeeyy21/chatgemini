import 'package:chatgemini/model.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  TextEditingController promptControl = TextEditingController();
  static const apiKey = "AIzaSyB3IglKXF43YzmhpL69JmDLJcz4_meoKXw";
  final model = GenerativeModel(model: "gemini-ai", apiKey: apiKey);

  final List<ModelMessage> prompt = [];
  final bool isPrompt = true;

  Future<void> sendMessage() async {
    final message = promptControl.text; // Fixed variable name
    setState(() {
      prompt.add(ModelMessage(isPrompt: isPrompt, message: message, time: DateTime.now())); // Fixed message and added time
    });
    promptControl.clear(); // Clear the input after sending
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.grey[300],
        title: const Text("Gemini AI"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: prompt.length,
              itemBuilder: (context, index) {
                final message = prompt[index];
                return UserPrompt(message, index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: TextField(
                    controller: promptControl,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Enter a prompt here",
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    sendMessage(); // Call sendMessage on tap
                  },
                  child: const CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container UserPrompt(ModelMessage message, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isPrompt ? Colors.blue[200] : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.message,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}