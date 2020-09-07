import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
   
   RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = [
    User(name: 'Maxim', email: 'maxiimruso7@gmail.com', uid:'uid1', online: false ),
    User(name: 'Natalia', email: 'Naty@naty.com', uid:'uid2', online: true ),
    User(name: 'Nazik', email: 'Nazar@test.com', uid:'uid3', online: false ),
    User(name: 'Styopa', email: 'Styopa@test.com', uid:'uid4', online: true ),
  ];



  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>( context );
    final user = authService.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}', style: TextStyle(color: Colors.black54)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54),
          onPressed: (){
            // TODO: Desonectar del socket server
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only( right: 10 ),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            // child: Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          waterDropColor: Colors.blue[400],
          complete: Icon(Icons.check, color: Colors.blue[400]),
        ),
        enablePullDown: true,
        controller: _refreshController,
        child: _listViewUsers(),
      )
   );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      padding: EdgeInsets.only(top:10),
      itemCount: users.length,
      itemBuilder: (_, i) => _userListTile(users.elementAt(i)),
      separatorBuilder: (_, i)=> Divider(), 
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
        leading: CircleAvatar(backgroundColor: Colors.blue[100],child: Text(user.name.substring(0,2))),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Icon(Icons.circle, color: user.online ?  Colors.green :  Colors.red, size: 10,),
      );
  }

  void _loadUsers() async{
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }


}