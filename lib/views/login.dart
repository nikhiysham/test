import 'package:flutter/material.dart';
import 'package:test/db/user_database.dart';
import 'package:test/helpers/functions.dart';
import 'package:test/helpers/hash.dart';
import 'package:test/model/user.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  _handleSubmit() async {
    if (formKey.currentState!.validate()) {
      await UserDatabase.login(User.fromJson({
        "email": emailCtrl.text,
        "password": Hash.generateMd5(pwdCtrl.text)
      })).catchError((e) {
        Functions.showAlertDialog(context, e);
      });

      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  _buildForm() {
    return Form(
        key: formKey,
        child: Column(children: [
          Container(
              child: TextFormField(
            controller: emailCtrl,
            validator: (val) => val!.isEmpty || !val.contains('@')
                ? "Enter valid email address"
                : null,
            decoration: InputDecoration(hintText: 'Email'),
          )),
          SizedBox(height: 10),
          Container(
              child: TextFormField(
            controller: pwdCtrl,
            validator: (val) => val!.isEmpty ? "Enter password" : null,
            obscureText: _showPassword ? true : false,
            decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )),
          )),
          SizedBox(height: 20),
          Container(
              child: MaterialButton(
                  color: Colors.green,
                  // padding: EdgeInsets.all(10),
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  onPressed: () => _handleSubmit())),
          SizedBox(height: 20),
          Container(
              child: InkWell(
                  child: Text("Create an account now",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  onTap: () => Navigator.of(context).pushNamed('register')))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(padding: EdgeInsets.all(20), child: _buildForm())));
  }
}
