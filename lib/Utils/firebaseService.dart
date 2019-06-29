import 'package:attendance_client/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // 获取用户头像
  getPath(String imageName) async {
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child('${imageName}.jpg');
    var downUrl = await storageRef.getDownloadURL();
    return downUrl.toString();
  }

  // 实例化数据库
  final db = Firestore.instance;

  // 增加员工用户并进行注册
  addUser(String id) async{
    // 注册用户
    
    String _email = id + "@xs.ustb.edu.cn";
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: id);
    // 数据库添加用户信息
    // DocumentReference ref = await db.collection('users').document(user.uid).setData(userMap);
    return user.uid;
    
  }

  // 根据uid请求用户数据
  Future<User> queryUser(String uid) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('users').document(uid).get();
    if (snapshot.data == null) {}
    User user = User(
        id: snapshot.data['id'],
        name: snapshot.data['name'],
        role: snapshot.data['role'],
        department: snapshot.data['department']);
    return user;
  }

// 请求所有员工信息
  Future<List<User>> queryUsers() async {
    DocumentSnapshot snapshot =
        await db.collection('users').document('TQJtEVDy1puFR75SbdUp').get();
    var data = snapshot.data['team'];
    List<User> users = [];
    for (var a in data) {
      User user = User(
          id: a['id'],
          name: a['name'],
          uid: a['uid'],
          sex: a['sex'],
          department: a['department'],
          role: a['role'],
          birth: a['birth']);
      users.add(user);
    }
    print(users[0].id);
    return users;
  }

  // 查找用户
  searchUserByID(){
    return db.collection('users')
      .where('id', isEqualTo: '41624158')
      .getDocuments();
  }



}

 