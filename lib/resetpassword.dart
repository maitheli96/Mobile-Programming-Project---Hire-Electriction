import 'package:flutter/material.dart';
import 'package:h_electriction/forgotpassword.dart';
import 'package:h_electriction/loginscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

String urlReset = "https://hireelectrian.com/h_electrician(user)/php/reset_password.php";

class ResetPasswordScreen extends StatefulWidget {

  final String email;
  ResetPasswordScreen({Key key, this.email}) : super(key: key);
  
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
    
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }
  

@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Reset Password'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: ResetWidget(email: widget.email,),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPassword(),
        ));
    return Future.value(false);
  }
}

class ResetWidget extends StatefulWidget {
    final String email;
  ResetWidget({Key key, this.email}) : super(key: key);

  @override
  _ResetWidgetState createState() => _ResetWidgetState(email);
}

class _ResetWidgetState extends State<ResetWidget> {
   final TextEditingController _tempasscontroller = TextEditingController();
  String _tempassword = "";
  final TextEditingController _passcontroller = TextEditingController();
  String _password = "";
String email;
  _ResetWidgetState(this.email);

 @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.email),
                    /*Text("Please enter your temporary password",
                      style: TextStyle( fontSize: 15)),

                    TextField(
                      controller: _tempasscontroller,
                      decoration: InputDecoration(
                          labelText: 'Temporary Password', icon: Icon(Icons.lock)),
                      obscureText: true,
                    ),*/
                    SizedBox(
                      height: 50,
                    ),
                    Text("Please enter your new password",
                      style: TextStyle( fontSize: 15)),

                    TextField(
                      controller: _passcontroller,
                      decoration: InputDecoration(
                          labelText: 'Password', icon: Icon(Icons.lock)),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Reset Password'),
                      color: Color.fromRGBO(38, 170, 250, 1),
                      textColor: Colors.black,
                      elevation: 15,
                      onPressed: _onVerify,
                    ),
                    SizedBox(
                      height: 10,
                    ),

      ],
    );
  }

  void _onVerify() {
    _tempassword = _tempasscontroller.text;
    _password = _passcontroller.text;
    email = widget.email;
    if (_password.length > 5) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Reset Password");
      pr.show();
      http.post(urlReset, body: {
       "email": email,
        "tempassword": _tempassword,
        "password": _password,
      }).then((res){
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (res.body == "success"){
          pr.dismiss();
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=> LoginPage())); 
        }else{
          pr.dismiss();
        }

      }).catchError((err){
          pr.dismiss();
          print(err);
    });
  } else{}
}

}