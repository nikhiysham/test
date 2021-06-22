import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:test/db/user_database.dart';
import 'package:test/helpers/functions.dart';
import 'package:test/helpers/hash.dart';
import 'package:test/model/user.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  _handleSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> param = {
          "name": nameCtrl.text,
          "email": emailCtrl.text,
          "password": Hash.generateMd5(pwdCtrl.text),
          "token": Uuid().v4().substring(0, 5),
          "createdAt": DateTime.now().toIso8601String()
        };
        await UserDatabase.register(User.fromJson(param)).catchError((e) {
          Functions.showAlertDialog(context, e);
        });

        Functions.showAlertDialog(
            context, "Registration success. You can login now", okAction: () {
          Navigator.of(context)
            ..pop()
            ..pushReplacementNamed('login');
        });
      } catch (e) {
        Functions.showAlertDialog(context, e.toString());
      }
    }
  }

  _buildForm() {
    return Form(
        key: formKey,
        child: Column(children: [
          Container(
              child: TextFormField(
            controller: nameCtrl,
            validator: (val) => val!.isEmpty ? "Enter name" : null,
            decoration: InputDecoration(hintText: 'Name *'),
          )),
          Container(
              child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailCtrl,
            validator: (val) => val!.isEmpty || !val.contains('@')
                ? "Enter valid email address"
                : null,
            decoration: InputDecoration(hintText: 'Email *'),
          )),
          SizedBox(height: 10),
          Container(
              child: TextFormField(
            controller: pwdCtrl,
            validator: (val) => val!.isEmpty ? "Enter password" : null,
            obscureText: _showPassword ? true : false,
            decoration: InputDecoration(
                hintText: 'Password *',
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
                    child:
                        Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                  onPressed: () => _handleSubmit())),
          SizedBox(height: 20),
          InkWell(
              child: Text("Already have an account? Login now",
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
              onTap: () => Navigator.of(context).pushReplacementNamed('login'))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                Container(padding: EdgeInsets.all(20), child: _buildForm())));
  }
}
