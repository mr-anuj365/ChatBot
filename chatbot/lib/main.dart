import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';
void main(){
  Gemini.init(apiKey:"AIzaSyDw3oXa-lWsGNZTfWErT__0VvAFNB6bhQQ");
  runApp(Chatbot());
}
class Chatbot extends StatefulWidget {

  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String response = "How can I help you ?";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
   appBar: AppBar(
     backgroundColor: Colors.purpleAccent,
     title: Row(
       children: [
         Icon(Icons.message),
         SizedBox(width: 10,),
         Text("chatbot"),
       ],
     ),
   ),
     body: Column(
       children: [
         Text("Welcome to chat bot",style: TextStyle(fontSize: 30,color: Colors.black),),
         Lottie.asset("assets/lottie/lottie_robot.json"),
        Expanded(child: SingleChildScrollView(
          child: Text(response),
        ))
       ,Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(
               width: 200,
               child: TextField(
                 controller:textEditingController,
                 decoration: InputDecoration(
                   labelText: "Enter your message"
                 ),
               ),

             ),
             SizedBox(width: 40,),
             ElevatedButton(onPressed: (){
               Gemini.instance.prompt(parts: [
                 Part.text(textEditingController.text),
               ]).then((value) {
                 setState(() {
                   response = value!.output!;
                 });
               }).catchError((e) {
                 print('error ${e}');
               });
             }, child: Icon(Icons.send))
           ],
         )
       ],
     ),
   );
  }
}
