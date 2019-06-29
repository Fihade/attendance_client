import 'package:attendance_client/Utils/firebaseService.dart';
import 'package:attendance_client/model/user.dart';
import 'package:attendance_client/pages/personalPage.dart';
import 'package:attendance_client/pages/userFormPage.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('团队成员'),
        centerTitle: true,
        backgroundColor: Color(0xff5954FF),
      ),
      body: FutureBuilder<List<User>>(
        future: FirebaseService().queryUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data[index].name),
                    onDismissed: (_) {

                    },
                    movementDuration: Duration(milliseconds: 100),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalPage(
                                      uid: snapshot.data[index].uid,
                                    )));
                      },
                      child: ListTile(
                        leading: FutureBuilder(
                          future: FirebaseService()
                              .getPath(snapshot.data[index].uid),
                          builder: (context, snapshot1) {
                            if (snapshot1.data == null)
                              return CircleAvatar(
                                  backgroundColor: Colors.white);
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(snapshot1.data),
                            );
                          },
                        ),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].department),
                      ),
                    ),
                  );
                },
              );
            default:
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<Null>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return UserFormDialog();
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff5954FF),
      ),
    );
  }
}
