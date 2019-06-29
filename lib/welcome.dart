import 'package:attendance_client/pages/managerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String _userEmail;
  String _userPassword;

  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 414, height: 736)..init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 32.0, right: 16.0),
        child: ListView(
          children: <Widget>[
            Text(
              "欢迎回来 :)",
              style: TextStyle(
                  // color: Color(0xff5954FF),
                  color: Colors.black,
                  fontSize: ScreenUtil(allowFontScaling: true).setSp(32),
                  // fontSize: 24,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 4),
            ),
            SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 60,
              ),
              child: Text(
                "通过个人ID和密码进行登陆，快来查看属于自己的相关信息吧 🔔",
                style: TextStyle(
                    color: Color(0xff595959),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 60.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xff000000).withAlpha(16),
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userEmailController,
                      validator: (input) {
                        if (input.isEmpty) {
                          return "员工 ID 不能为空";
                        }
                      },
                      onEditingComplete: _signIn,
                      onSaved: (input) {
                        _userEmail = input+"@xs.ustb.edu.cn";
                      },
                      decoration: InputDecoration(
                        labelText: "员工ID",
                        labelStyle: TextStyle(
                          color: Colors.grey
                        ),
                        icon:
                            Icon(Icons.verified_user, color: Color(0xff5954FF)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xff000000).withAlpha(16),
                              offset: Offset(0, 3),
                              blurRadius: 6
                          )
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: _userPasswordController,
                      validator: (input) {
                        if (input.length < 6) {
                          return "密码至少6位，请确认您的密码";
                        }
                      },
                      onEditingComplete: _signIn,
                      onSaved: (input) => _userPassword = input,
                      decoration: InputDecoration(
                        // fillColor: Color(0xffECF1F3),
                        labelText: "密码",
                        labelStyle: TextStyle(
                          color: Colors.grey
                        ),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xff5954FF),
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _userEmailController.clear();
                    _userPasswordController.clear();
                  },
                  child: Text("取消"),
                ),
                RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Color(0xffff5954FF),
                  child: Text(
                    "登陆",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _signIn,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    final _formState = _formKey.currentState; 
    if (_formState.validate()) {
      _formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _userEmail,password: _userPassword);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ManagerHomePage(user: user)
        ));
      }catch(e){
  
      }
    }
  }
}
