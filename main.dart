import 'package:flutter/material.dart';

import 'package:flutter_dialogflow/dialogflow_v2.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  void response(query) async{
    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/smiling-spring-282206-f1a4af6a2882.json").build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle ,language:Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data":0,
        "message":aiResponse.getListMessage()[0]["text"]["text"][0].toString()
        });
      
      });
     
    }

  final messageInsert= TextEditingController();
  List<Map> messages=List();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patooties",
        ),
        backgroundColor: Colors.pink[600],
      ),
      

      body: Container(

        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(10.0),
                itemCount: messages.length,
                itemBuilder:(context,index)=>messages[index]["data"]==0
                ?Text(messages[index]["message"].toString())
                : Text(messages[index]["messages"].toString(),textAlign: TextAlign.right,)),
              ),
                
            Divider(height: 3.0
            ),
            Container(
              padding: EdgeInsets.only(bottom:20.0),
              margin: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(children: <Widget>[
                Flexible(
                    child: TextField(
                  controller: messageInsert,
                  decoration: InputDecoration.collapsed(
                    hintText: "Send Your Message"),

                )),
              Container(margin: EdgeInsets.symmetric(horizontal:4.0),
              child: IconButton(icon:Icon(Icons.send), onPressed: (){
                if(messageInsert.text.isEmpty)
                {
                  print("empty message");
                }
                else {
                  setState(() {
                    messages.insert(0, {"data":1,"message":messageInsert.text});
                    
                  });

                  response(messageInsert.text);
                  messageInsert.clear();
                }


              }),
              )
              ],
              ),
               )
          ],
          )
      ),
    );
  }
}

//import flutter dialogflow 