import 'package:attendance_client/Utils/ItemList.dart';
import 'package:attendance_client/Utils/firebaseService.dart';
import 'package:attendance_client/pages/personalPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ManagerHomePage extends StatefulWidget {
  final FirebaseUser user;

  const ManagerHomePage({Key key, this.user}) : super(key: key);

  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {

  var u;

  @override
  void initState() { 
    
    FirebaseService()
      .searchUserByID()
      .then((QuerySnapshot docs) {
        if (docs.documents.isNotEmpty) {
          u = docs.documents[0].data;
          print('u:${u}');
        }
      });

    super.initState();
  }

  Widget build(BuildContext context) {
    double _heightTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: _heightTop + 90,
            color: Color(0xff5954FF),
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    _buildUserNamebyId(widget.user)
                  ],
                ),
                Spacer(),
                FutureBuilder(
                  future: FirebaseService().getPath(widget.user.uid),
                  builder: (context,snapshot){
                    if(snapshot.data == null )
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                      );
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PersonalPage(uid: widget.user.uid,)
                        ));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          snapshot.data
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Items(),
          )
        ],
      ),
    );
  }
}

Widget _buildUserNamebyId(FirebaseUser user){
  return StreamBuilder<DocumentSnapshot>(
    stream: Firestore.instance
      .collection('users')
      .document(user.uid)
      .snapshots(),
    builder: (context, snapshot) {
      if(snapshot.hasError) {
            return Text('Null');
      }
      switch (snapshot.connectionState){
        case ConnectionState.waiting:
          return Text("Loading...");
        default:
          return Text(
            snapshot.data['name'],
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 24,
              letterSpacing: 2
            ),
          );
      }
    });
}


class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 10,
        children: getCardList(context));
  }

  List<String> getDataList() {
    List<String> list = [];
    for (int i = 0; i < 6; i++) {
      list.add(i.toString());
    }
    return list;
  }

  List<Widget> getCardList(BuildContext context) {
    return listItems.map((item) => getItemContainer(item, context)).toList();
  }

  Widget getItemContainer(Item item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, item.route);
      },
      child: Container(
          width: 5.0,
          height: 5.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xff000000).withAlpha(24),
                    offset: Offset(0, 3),
                    blurRadius: 32)
              ]),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  item.icon,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16),
              Text(
                item.name,
                style: TextStyle(color: Color(0xff8a8a8a), fontSize: 16),
              )
            ],
          )),
    );
  }
}
