import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  // form key
  final _formKey = GlobalKey<FormState>();

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
        onPressed: () {},
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
}
