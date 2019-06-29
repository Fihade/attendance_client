import 'package:attendance_client/Utils/firebaseService.dart';
import 'package:attendance_client/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PersonalPage extends StatelessWidget {
  final String uid;

  const PersonalPage({Key key, this.uid}) : super(key: key);
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人账户'),
        centerTitle: true,
        backgroundColor: Color(0xff5954FF),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          _getAvatar(uid),
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_getUserInfo(uid)],
          ),

        ],
      ),
    );
  }
}

Widget _getAvatar(String uid) {
  return FutureBuilder(
    future: FirebaseService().getPath(uid),
    builder: (context, snapshot) {
      if (snapshot.data == null)
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xff000000).withAlpha(16),
                          offset: Offset(0, 3),
                          blurRadius: 6)
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                )),
          ],
        );
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 80,
              width: 80,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xff000000).withAlpha(16),
                    offset: Offset(0, 3),
                    blurRadius: 6)
              ]),
              child: GestureDetector(
                onTap: (){
                  print('hahhahaha');
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(snapshot.data),
                ),
              )),
        ],
      );
    },
  );
}

Widget _getUserInfo(String uid) {
  return FutureBuilder<User>(
    // stream: Firestore.instance.collection('users').document(uid).snapshots(),
    future: FirebaseService().queryUser(uid),
    builder: (context, snapshot) {
      if (snapshot.data == null) {
        return null;
      }
      
      return Column(
        children: <Widget>[
          Text(
            snapshot.data.id,
            style: TextStyle(color: Colors.grey[500]),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            snapshot.data.name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 4),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            snapshot.data.department,
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold),
          )
        ],
      );
    },
  );
}
