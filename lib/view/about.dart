import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  hintAttachment(BuildContext context) {
    final _hackTip =
        "The attachment Feature is not supported with whatsapp api😔!\nSo here is a hack😍\n1. Send a Greeting first through this app\n2. The name will be added in your whatsapp chat history! Then you can send the addtachment from the app itself\nSee you don't required to save that persons number!😁";
    return Card(
      margin: const EdgeInsets.all(30.0),
      shadowColor: Theme.of(context).primaryColor,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "PRO T!P 🤓\n",
              style: TextStyle(color: Colors.purple),
            ),
            Text(_hackTip),
          ],
        ),
      ),
    );
  }

  developerInfo(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30.0),
      shadowColor: Theme.of(context).primaryColor,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "About the developer 😎\n",
              style: TextStyle(color: Colors.purple),
            ),
            Text("Jay Saha 👨🏻‍💻"),
            Text("This app is created uisng flutter ❤️")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/about_background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    hintAttachment(context),
                    developerInfo(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
