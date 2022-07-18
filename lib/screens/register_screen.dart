import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:register_form/models/user_model.dart';
import 'package:register_form/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  // form key
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  // editing controller

  final firstNameEditController = new TextEditingController();
  final lastNameEditController = new TextEditingController();
  final emailEditController = new TextEditingController();
  final passwordEditController = new TextEditingController();
  final confirmPasswordEditController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //firstname Field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty){
          return ("First Name can not be Empty!");
        }

        if (!regex.hasMatch(value)){
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );

    //lastname Field
    final lastNameField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: lastNameEditController,
      validator: (value){
        if (value!.isEmpty){
          return ("First Name cannot be Empty!");
        }
        return null;
      },
      onSaved: (value){
        lastNameEditController.text = value!;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Last Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );

    //email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value){
        if (value!.isEmpty){
          return "Please Enter your Email";
        }

        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]").hasMatch(value)){
          return ("Please Enter a Valid email");
        }

        return null;
      },
      onSaved: (value) {
        emailEditController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
      ),
    );

    //password Field
    final passwordField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.done,
      controller: passwordEditController,
      validator: (value){
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty){
          return ("Password is required for Register");
        }

        if (!regex.hasMatch(value)){
          return ("Please Enter Valid Password(Min. 6 Character)");
        }

        return null;
      },
      onSaved: (value) {
        passwordEditController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Password",
      ),
      obscureText: true,
    );

    //confirm password Field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.done,
      validator: (value){
        if (confirmPasswordEditController.text != passwordEditController.text){
          return ("Password don't match");
        }

        return null;
      },
      onSaved: (value) {
        confirmPasswordEditController.text = value!;
      },
      controller: confirmPasswordEditController,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        hintText: "Confirm Password",
      ),
    );

    //signup Button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          SignUp(emailEditController.text, passwordEditController.text);
        },
        child: Text(
          "SignUp",
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,size: 30,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 180,
                      child: Image.asset(
                        "assets/flutter_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45,),
                    firstNameField,
                    SizedBox(height: 20,),
                    lastNameField,
                    SizedBox(height: 20,),
                    emailField,
                    SizedBox(height: 20,),
                    passwordField,
                    SizedBox(height: 20,),
                    confirmPasswordField,
                    SizedBox(height: 20,),
                    signUpButton,
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SignUp(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            postDetailToFirestore()
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailToFirestore() async{
    //calling fireStore
    //calling userModel
    //sending these value

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = firstNameEditController.text;
    userModel.lastname = lastNameEditController.text;

    await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account is created Successfully :) ");

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
  }
}
