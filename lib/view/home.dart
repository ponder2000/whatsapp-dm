import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_dm/view/about.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String mobileNumber = "";
  TextEditingController messageController = TextEditingController();

  double windowHeight, windowWidth;

  bool _emptyMsg = false;
  bool _inValidMobileNum = false;

  backgroundImage() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        child: Image.asset(
          'assets/background.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  foregroundWidget() {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: windowWidth * 0.8,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "Send WhatsApp message 📲 to any number without saving it 😎",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            Divider(height: 20.0),

            // Mobile Number
            Container(
              width: windowWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: IntlPhoneField(
                initialCountryCode: "IN",
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: InputBorder.none,
                  hintText: "10 digit mobile number here",
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                onChanged: (val) {
                  mobileNumber = val.completeNumber;
                  print(mobileNumber);
                },
                onSaved: (val) {
                  mobileNumber = val.completeNumber;
                },
              ),
            ),

            Divider(height: 10.0),

            // Message
            Container(
              height: windowHeight * 0.35,
              width: windowWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: InputBorder.none,
                  hintText: "Your message here",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                expands: false,
                controller: messageController,
              ),
            ),
            Divider(height: 10.0),
          ],
        ),
      ),
    );
  }

  bool isGoodRequest() {
    if (mobileNumber.length < 12) {
      _inValidMobileNum = true;
    } else {
      _inValidMobileNum = false;
    }

    if (messageController.text.isEmpty) {
      _emptyMsg = true;
    } else {
      _emptyMsg = false;
    }
    print(_inValidMobileNum);
    print(_emptyMsg);
    return (!_inValidMobileNum) && (!_emptyMsg);
  }

  // open whatsapp
  launchWhatsApp() async {
    final _url =
        "https://wa.me/${mobileNumber.substring(1)}?text=${messageController.text}";
    await launch(_url);
  }

  handleSendMsg() {
    if (isGoodRequest()) {
      launchWhatsApp();
      final _snackBar = SnackBar(
        content: Text('sending...'),
      );
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    } else if (_inValidMobileNum) {
      // print(mobileNumber);
      final _snackBar = SnackBar(
        content: Text('Enter a valid mobile number'),
      );
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    } else if (_emptyMsg) {
      // print(messageController.text);
      final _snackBar = SnackBar(
        content: Text('Your msg is empty!'),
      );
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    } else {
      final _snackBar = SnackBar(
        content:
            Text('invalid request check your mobile number and message again'),
      );
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          backgroundImage(),
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  padding: EdgeInsets.only(right: 30.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.info,
                    size: 40.0,
                    color: Colors.deepOrange.withOpacity(0.8),
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.send),
              onPressed: () => handleSendMsg(),
            ),
            body: foregroundWidget(),
          ),
        ],
      ),
    );
  }
}
