import 'package:attendance_client/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class UserFormDialog extends StatefulWidget {
  UserFormDialog({Key key}) : super(key: key);

  _UserFormDialogState createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _selectedMale;
  String name;
  String id;
  String uid;
  String sex;
  String role;
  String department;
  int birth;

  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedMale = 0;
  }

  setSelectedMale(int val) {
    setState(() {
      _selectedMale = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            // height: 200,
            // width: 300,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 80, bottom: 80, right: 40, left: 40),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Text(
                      "添加员工",
                      style: TextStyle(
                          color: Color(0xff5954FF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              // color: Color(0xff5954FF),
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              onSaved: (input) => name = input,
                              decoration: InputDecoration(
                                  hintText: "员工姓名",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              color: Colors.grey[200],
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              onSaved: (input) => id = input,
                              decoration: InputDecoration(
                                  hintText: "员工ID",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              color: Colors.grey[200],
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              onSaved: (input) => department = input,
                              decoration: InputDecoration(
                                  hintText: "部门",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              color: Colors.grey[200],
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              onSaved: (input) => role = input,
                              decoration: InputDecoration(
                                  hintText: "职位",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "性别：",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              Text(
                                "男",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              Radio(
                                  value: 1,
                                  groupValue: _selectedMale,
                                  activeColor: Color(0xff5954FF),
                                  onChanged: (val) => setSelectedMale(val)),
                              Text(
                                "女",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              Radio(
                                  value: 0,
                                  groupValue: _selectedMale,
                                  activeColor: Color(0xff5954FF),
                                  onChanged: (val) => setSelectedMale(val)),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '出生年月:',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1019, 3, 5),
                                      maxTime: DateTime.now(),
                                      onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    setState(() {
                                      birth = date.year;
                                    });

                                    print(birth);
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.zh);
                                },
                                color: Colors.grey[200],
                                child: Text("选择日期"),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text('${birth}')
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            // TODO:
                            onPressed: () {
                              _savedUserInformation();
                              _registerUser();
                              while (uid == null) {
                                user = User(
                                  id: id,
                                  name: name,
                                  sex: _selectedMale == 1 ? '男' : '女',
                                  department: department,
                                  birth: birth,
                                  role: role,
                                  uid: uid,
                                );
                              }
                              print(uid);
                              _addUser2Database(user);
                            },
                            color: Color(0xff5954FF),
                            child: Text(
                              "添加",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("取消"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  // 保存用户
  _savedUserInformation() async {
    final _formState = _formKey.currentState;
    _formState.save();

    // print(user.uid);
  }

  // 注册用户
  _registerUser() async {
    String _email = id + "@xs.ustb.edu.cn";
    FirebaseUser registerUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: id);
    uid = registerUser.uid;
  }

  // 添加用户进数据库 
  _addUser2Database(User user) async {
    // DocumentReference ref =  Firestore.instance.collection('users').document(user.uid).collection('');
    Map<String,dynamic> userInfo = {
      "role": user.role,
      "sex": user.sex,
      "name": user.name,
      "birth": user.birth,
      'id': user.id,
      'department': user.department,
      'uid': user.uid
    };
    FirebaseDatabase.instance.reference().child('users/TQJtEVDy1puFR75SbdUp').child('/team').set(userInfo);
    // await Firestore.instance.collection('users').document('TQJtEVDy1puFR75SbdUp').collection('team').add(userInfo);
    // print(ref.documentID);
  }
}
