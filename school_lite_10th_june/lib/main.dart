// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:school_lite_10th_june/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Desk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool isHiddenPassword = true;

  final UserNameController = TextEditingController();
  final PasswordController = TextEditingController();

  var SerialNumber;
  var HostName;
  var HostMAC;
  var LoginProvider;
  var ProviderKey;
  var NotificationToken;
  var LocalIP;
  var LastSeen;
  var PublicIP;
  var SessionHostId;

  void login(
    String UserName,
    String Password,
    SerialNumber,
    HostName,
    HostMAC,
    LoginProvider,
    SessionHostId,
    ProviderKey,
    LastSeen,
    PublicIP,
    LocalIP,
    NotificationToken,
  ) async {
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response response = await post(
      Uri.parse('https://mtestsd.rbkei.in/api/CreateTokan'),
      body: {
        'UserName': UserName,
        'Password': Password,
        'SerialNumber': SerialNumber,
        'HostName': HostName,
        'HostMAC': HostMAC,
        'LoginProvider': LoginProvider,
        'ProviderKey': ProviderKey,
        'LastSeen': LastSeen,
        'PublicIP': PublicIP,
        'LocalIP': LocalIP,
        'NotificationToken': NotificationToken,
      },
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        sharedPreferences.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
      );
    } else {
      print(response.body);
    }
  }

  bool? newuser;

  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    UserNameController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.amber,
        systemNavigationBarDividerColor: Color.fromARGB(255, 170, 167, 167),
        systemNavigationBarColor: Color.fromARGB(255, 170, 167, 167),
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                          width: 30,
                        ),
                        Image.asset(
                          'assets/bee.png',
                          height: 80.0,
                          width: 120.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'SCHOOL DESK',
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontSize: 18, letterSpacing: 5),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, letterSpacing: 2),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 27),
                      decoration: const BoxDecoration(),
                      child:
                          ////////////////////////////////////////email//////////////////////////////////////////////////
                          TextFormField(
                        controller: UserNameController,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                        cursorColor: Color.fromARGB(255, 255, 204, 0),
                        decoration: InputDecoration(
                          labelText: 'Your E-mail',
                          hintText: 'abc@gmail.com',
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: BorderSide(color: Colors.black45)),
                        ),
                      ),
                    ),
                    ///////////////////////////////////password////////////////////////////////////////////
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 27),
                      decoration: const BoxDecoration(),
                      child: TextFormField(
                        controller: PasswordController,
                        keyboardType: TextInputType.phone,
                        cursorColor: Color.fromARGB(255, 255, 204, 0),
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                          hoverColor: Color.fromARGB(255, 255, 204, 0),
                          labelText: 'Password:',
                          hintText: '****',
                          suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(Icons.visibility)),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle:
                              TextStyle(color: Colors.black45, fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: BorderSide(color: Colors.black45)),
                        ),
                        validator: MinLengthValidator(3,
                            errorText: "At least 3 Character"),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        login(
                            UserNameController.text.toString(),
                            PasswordController.text.toString(),
                            SerialNumber.toString(),
                            HostName.toString(),
                            HostMAC.toString(),
                            LoginProvider.toString(),
                            SessionHostId.toString(),
                            ProviderKey.toString(),
                            LastSeen.toString(),
                            PublicIP.toString(),
                            LocalIP.toString(),
                            NotificationToken.toString());

                      
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(27)),
                          child: Center(
                            child: Text('Login'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
