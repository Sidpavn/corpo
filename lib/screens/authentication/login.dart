
import 'dart:async';

import 'package:corpo/common/enums/enums.dart';
import 'package:corpo/common/statics.dart';
import 'package:corpo/models/themes/theme.dart';
import 'package:corpo/screens/homepage/homepage.dart';
import 'package:corpo/services/player/create_documents.dart';
import 'package:corpo/widgets/other_widgets/bottom_model_sheet.dart';
import 'package:corpo/widgets/other_widgets/button_widgets.dart';
import 'package:corpo/widgets/login/login_widgets.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:username_gen/username_gen.dart';
import 'package:device_info/device_info.dart';
import '../../providers/network_connectivity.dart';
import '../../services/cache/read_cache_data.dart';
import '../../services/snackbar/call_snackbar.dart';

import '../../widgets/other_widgets/network_error.dart';

class LoginPage extends StatefulWidget {

  final bool isReload;
  LoginPage({required this.isReload});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
  String username = '';
  LocalStorage storage = LocalStorage('corpo');
  bool isAbsorbed = false, hidePassword = true, hideConfirmationPassword = true;
  String device = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController resetEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  FocusNode passwordNode2 = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  final validateMode = AutovalidateMode.disabled;
  bool isSignUp = false;
  bool isSignIn = false;
  bool isResetPasswordSent = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    username = UsernameGen().generate();
    if(widget.isReload){
      reloadAuthChange();
    }
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      device = await getDeviceInfo();
    });
  }

  @override
  void dispose() {
    passwordNode.dispose();
    passwordNode2.dispose();
    _timer?.cancel();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state) {
      case AppLifecycleState.resumed: {
        reloadAuthChange();
        break;
      }
      default: break;
    }
  }

  reloadAuthChange() async {
    setState(() {
      if (_auth.currentUser != null && _auth.currentUser!.emailVerified == false){
        _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
          debugPrint("Verified Status :: ${_auth.currentUser!.emailVerified.toString()}");
          _auth.currentUser!.reload();
          if(_auth.currentUser!.emailVerified){
            _timer!.cancel();
            await createUser(_auth.currentUser!.uid, "email");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if(Provider.of<InternetConnection>(context).connection) {
      return WillPopScope(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            },
            child: Scaffold(
              backgroundColor: ColorTheme.black,
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        children: [
                          loginColumn(height)
                        ],
                      )
                    ),
                  );
                },
              ),
            )
          ),
        ),
        onWillPop: () async => false,
      );
    } else {
      return networkError();
    }
  }

  Widget loginColumn(double height){
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.fromLTRB(0,0,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nicheMarabu(),
          Expanded(
            child: Center(
              child: headline0(true, title: "CORPO\nOVERLORDS", textAlign: TextAlign.center, color: ColorTheme.yellow),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_auth.currentUser != null && _auth.currentUser!.emailVerified == false)...{
                  verificationContainer()
                }
                else...{
                  if(!isAbsorbed)...{
                    if(!isSignUp && !isSignIn)...{
                      authContainer(),
                    },
                    if(isSignUp)...{
                      formField(true),
                      authButton(true),
                      disclaimer("If you're not happy with the generated username, feel free to regenerate to get a new one."),
                    },
                    if(isSignIn)...{
                      formField(false),
                      authButton(false),
                      disclaimer("If you don't have an account yet, you can create one for free.")
                    },
                  }
                  else...{
                    authenticationIndicator()
                  },
                }
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget verificationContainer(){
    return Container(
      color: ColorTheme.creme,
      child: centerColumn(false,
        child: Column(
            children: [
              Row(
                children: [
                  flexBox(true, flex: 1, color: ColorTheme.creme, border: [0,1,0,0],
                      widget: Container(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: centerColumn(false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headline2(true, title: "Verify your email", textAlign: TextAlign.left, color: ColorTheme.black),
                                  const SizedBox(height: 2),
                                  subtitle(false, title: "We have sent a verification email to ${_auth.currentUser!.email!}.\n\n"
                                      "Once you click on the link, your email address will be automatically verified.", textAlign: TextAlign.left, color: ColorTheme.black),
                                ],
                              )
                          )
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  flexBox(true, flex: 1, color: _auth.currentUser!.emailVerified ? ColorTheme.neonGreen : ColorTheme.darkRed, border: [0,1,0,0],
                      widget: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: centerColumn(true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(!_auth.currentUser!.emailVerified)...{
                                    headline3(true, title: "You are not verified yet", textAlign: TextAlign.center, color: ColorTheme.white),
                                  } else...{
                                    headline3(true, title: "You are verified", textAlign: TextAlign.center, color: ColorTheme.black),
                                  }
                                ],
                              )
                          )
                      )
                  ),
                ],
              ),
              disclaimer("It's important to verify your email to ensure the security of your account and to prevent unauthorized access.\n\n"
                  "Verification helps us confirm that you are the rightful owner of the email address and "
                  "allows us to communicate important information regarding your account.")
            ],
          )
      )
    );
  }

  Widget authContainer(){
    return Container(
        color: ColorTheme.creme,
        child: Column(
          children: [
            Row(
              children: [
                flexBox(false, flex: 1, color: null, border: [0,1,0,1],
                  widget: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSignUp = true;
                      });
                    },
                    child: signUpButton(ColorTheme.yellow)
                  )
                ),
                flexBox(false, flex: 1, color: null, border: [1,1,0,1],
                  widget: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSignIn = true;
                      });
                    },
                    child: signInWithEmailButton(ColorTheme.yellow)
                  )
                ),
              ],
            ),
            Row(
              children: [
                flexBox(false, flex: 1, color: null, border: [0,0,0,0],
                  widget: GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: googleButton(ColorTheme.neonGreen)
                  )
                ),
              ],
            ),
            termsAndConditions(),
          ],
        )
    );
  }

  Widget formField(bool isRegister){
    return Row(
      children: [
        flexBox(false, flex: 1, color: ColorTheme.white, border: [0,1,0,0],
          widget: Form(
            key: formKey,
            autovalidateMode: validateMode,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,20,20,60),
              child: Column(
                children: [
                  if(isRegister)...{
                    generateUsernameButton(),
                  },
                  const SizedBox(height: 20),
                  emailField(),
                  const SizedBox(height: 20),
                  passwordField(isRegister),
                  if(isRegister)...{
                    const SizedBox(height: 20),
                    confirmationPasswordField(),
                  }
                  else...{
                    const SizedBox(height: 40),
                    resetPassword(),
                    if(isResetPasswordSent)...{
                      const SizedBox(height: 20),
                      resetPasswordSent(),
                    }
                  }
                ],
              ),
            )
          )
        )
      ]
    );
  }

  Widget authButton(bool isRegister){
    return Column(
      children: [
        Row(
          children: [
            flexBox(true, flex: 1, color: ColorTheme.darkRed, border: [0,1,1,0],
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    if(isRegister){
                      isSignUp = false;
                    } else {
                      isSignIn = false;
                    }
                    emailController.clear();
                    passwordController.clear();
                    confirmationPasswordController.clear();
                  });
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                },
                child: actionButton("Go back", ColorTheme.darkRed, ColorTheme.white)
              )
            ),
            flexBox(true, flex: 1, color: ColorTheme.yellow, border: [0,1,0,0],
              widget: GestureDetector(
                onTap: () {
                  if(isRegister){
                    createAccount();
                  }
                  else {
                    signIn();
                  }
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                },
                child: actionButton(isRegister ? "Continue" : "Sign in", ColorTheme.yellow, ColorTheme.black)
              )
            ),
          ],
        ),
      ],
    );
  }

  Widget generateUsernameButton(){
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          flexBox(false, flex: 5, color: ColorTheme.white, border: [0,0,0,0],
              widget: centerColumn(false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    info(false, title: "Your generated username", textAlign: TextAlign.left, color: ColorTheme.black),
                    headline3(false, title: username, textAlign: TextAlign.left, color: ColorTheme.black),
                  ],
                )
              )
          ),
          flexBox(false, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
              widget: Container(
                height: 60,
                width: 60,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      username = UsernameGen().generate();
                    });
                  },
                  child: button(
                      color: ColorTheme.black,
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.refresh, size: 25, color: ColorTheme.white)
                  ),
                ),
              )
          ),
        ]
    );
  }

  Widget emailField(){
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      style: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.black, height: 1),
      decoration: InputDecoration(
        hintText: 'Email address',
        hintStyle: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.grey.withOpacity(0.7), height: 1),
        errorStyle: GoogleFonts.epilogue(fontSize: FontSize.subtitle, fontWeight: FontWeight.w500, color: ColorTheme.darkRed, height: 1),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.darkRed, width: 1.5)),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(passwordNode);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Email field is required.";
        }
        if (!isValidEmail(value)) {
          return 'Please enter valid email';
        }
        return null;
      },
    );
  }

  Widget passwordField(bool isRegister){
    return TextFormField(
      focusNode: passwordNode,
      obscureText: hidePassword,
      controller: passwordController,
      autofillHints: const <String>[AutofillHints.password],
      style: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.black, height: 1),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.grey.withOpacity(0.7), height: 1),
        errorStyle: GoogleFonts.epilogue(fontSize: FontSize.subtitle, fontWeight: FontWeight.w500, color: ColorTheme.darkRed, height: 1),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.darkRed, width: 1.5)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {hidePassword = !hidePassword;});
          },
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
              color: ColorTheme.black
          ),
        ),
      ),
      textInputAction: isRegister ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (value) {
        if(isRegister){
          FocusScope.of(context).requestFocus(passwordNode2);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Password field is required.";
        } else if (value.length < 6) {
          return "Password must be more than six characters.";
        }
        return null;
      },
    );
  }

  Widget confirmationPasswordField(){
    return TextFormField(
      focusNode: passwordNode2,
      obscureText: hideConfirmationPassword,
      controller: confirmationPasswordController,
      style: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.black, height: 1),
      decoration: InputDecoration(
        hintText: 'Confirmation password',
        hintStyle: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.grey.withOpacity(0.7), height: 1),
        errorStyle: GoogleFonts.epilogue(fontSize: FontSize.subtitle, fontWeight: FontWeight.w500, color: ColorTheme.darkRed, height: 1),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.darkRed, width: 1.5)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {hideConfirmationPassword = !hideConfirmationPassword;});
          },
          icon: Icon(hideConfirmationPassword ? Icons.visibility_off : Icons.visibility,
              color: ColorTheme.black
          ),
        ),
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value){
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Confirmation password field is required.";
        } else if (value != passwordController.text.trim()) {
          return "Password does not match!";
        }
        return null;
      },
    );
  }

  Widget resetEmailField(){
    return TextFormField(
      controller: resetEmailController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      style: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.black, height: 1),
      decoration: InputDecoration(
        hintText: 'Email address',
        hintStyle: GoogleFonts.epilogue(fontSize: FontSize.title, fontWeight: FontWeight.w500, color: ColorTheme.grey.withOpacity(0.7), height: 1),
        errorStyle: GoogleFonts.epilogue(fontSize: FontSize.subtitle, fontWeight: FontWeight.w500, color: ColorTheme.darkRed, height: 1),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.black, width: 1.5)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorTheme.darkRed, width: 1.5)),
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        FocusManager.instance.primaryFocus?.unfocus();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Email field is required.";
        }
        if (!isValidEmail(value)) {
          return 'Please enter valid email';
        }
        return null;
      },
    );
  }

  Widget resetPassword(){
    return GestureDetector(
        onTap: () {
          showResetModal();
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        },
        child: Container(
          width: double.infinity,
          child: centerColumn(false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subtitle(false, title: 'Forgot password?', textAlign: TextAlign.left, color: ColorTheme.black),
                headline3(true, title: 'Reset your password', textAlign: TextAlign.left, color: ColorTheme.black)
              ],
            ),
          ),
        )
    );
  }

  showResetModal(){
    resetPasswordModal(context,
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20,20,20,40),
            child: Form(
                key: resetFormKey,
                autovalidateMode: validateMode,
                child: resetEmailField()
            ),
          ),
          Row(
            children: [
              flexBox(true, flex: 1, color: ColorTheme.yellow, border: [0,1,0,0],
                  widget: GestureDetector(
                      onTap: () {
                        sentResetEmail();
                      },
                      child: actionButton("Submit", ColorTheme.yellow, ColorTheme.black)
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  // Authentication functions

  Future createAccount() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty && confirmationPasswordController.text.trim().isNotEmpty){
        setState(() {isAbsorbed = true;});
        await checkIfEmailInUse(emailController.text.trim()).then((isEmailInUse) async {
          if(!isEmailInUse) {
            try{
              final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
              );
              authCheck(userCredential, "email");
            } on FirebaseAuthException catch (e) {
              setState(() {isAbsorbed = false;});
              callSnackBar(context, 3500, headline: "Warning", content: "Unable to create an account", isError: true, color: ColorTheme.white);
              return e.message;
            }
          } else {
            setState(() {isAbsorbed = false;});
            callSnackBar(context, 3500, headline: "Warning", content: "This email is already in use", isError: true, color: ColorTheme.white);
          }
        });
      }
    }
  }

  Future signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty){
        setState(() {isAbsorbed = true;});
        try{
          final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()
          );
          authCheck(userCredential, "email");
        } on FirebaseAuthException catch (e) {
          setState(() {isAbsorbed = false;});
          callSnackBar(context, 3500, headline: "Warning", content: "Unable to sign into your account", isError: true, color: ColorTheme.white);
          return e.message;
        }
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        setState(() {isAbsorbed = true;});
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        authCheck(userCredential, "google");
      }
      callSnackBar(context, 3500, headline: "Warning", content: "Unable to sign in with Google", isError: true, color: ColorTheme.white);
    } catch (e) {
      setState(() {isAbsorbed = false;});
      callSnackBar(context, 3500, headline: "Warning", content: "Unable to sign in with Google", isError: true, color: ColorTheme.white);
    }
  }

  Future authCheck(UserCredential userCredential, String authType) async {
    final User? user = userCredential.user;

    if (user != null) {
      usersRef.doc(user.uid).get().then((doc) async {
        if (doc.exists) {
          if(doc.get('device_id').toString() == '' || doc.get('device_id').toString() == device){
            ReadCacheData().readCache().whenComplete(() async {
              String uid = FirebaseAuth.instance.currentUser!.uid;
              CollectionReference<Map<String, dynamic>> userRef = FirebaseFirestore.instance.collection("Users");
              Map<String, dynamic> player = storage.getItem('player');
              player.update('device_id', (value) => device);
              await userRef.doc(uid).update(player).whenComplete(() {
                callSnackBar(context, 3500, headline: "Success", content: "Welcome back!", isError: false, color: ColorTheme.black);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Homepage(),
                  ),
                );
              });
            });
          }
          else {
            setState(() {isAbsorbed = false;});
            signOut().whenComplete((){
              otherDeviceLoggedIn(context);
            });
          }
        }
        else {
          if(authType == "email"){
            _auth.currentUser!.sendEmailVerification();
            setState(() {
              Map<String, dynamic> tempData = {
                "username": username,
                "device_id": device,
                "auth_type": authType
              };
              storage.setItem("temp_data", tempData);
              isAbsorbed = false;
            });
            reloadAuthChange();
          }
          else if(authType == "google"){
            await createUser(user.uid, authType);
          }
        }
      });
    }
  }

  Future createUser(String uid, String authType) async {
    if(authType == "email"){
      Map<String, dynamic> tempData = storage.getItem("temp_data");
      username = tempData["username"] ?? UsernameGen().generate();
      device = tempData["device"] ?? "";
      authType = tempData["auth_type"] ?? "email";
    }
    usersRef.doc(uid).set(fetchPlayerDoc(username, device, authType)).whenComplete(() {
      usersRef.doc(uid).collection('inventory').doc('storage').set(fetchStorageDoc());
    }).whenComplete(() {
      ReadCacheData().readCache().whenComplete(() async {
        callSnackBar(context, 3500, headline: "Success", content: "Welcome to Corpo Overlords!", isError: false, color: ColorTheme.black);
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => Homepage(),
            ),
          );
        });
      });
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginPage(isReload: false),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  Future sentResetEmail() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (resetFormKey.currentState!.validate()) {
      if (resetEmailController.text.trim().isNotEmpty){
        try{
          if(!isResetPasswordSent){
            setState(() {isResetPasswordSent = true;});
            _auth.sendPasswordResetEmail(email: resetEmailController.text.trim());
            callSnackBar(context, 3500, headline: "Success", content: "Password reset email has been sent", isError: false, color: ColorTheme.black);
          } else {
            callSnackBar(context, 3500, headline: "Warning", content: "Email has been already sent", isError: true, color: ColorTheme.white);
          }
        } on FirebaseAuthException catch (e) {
          callSnackBar(context, 3500, headline: "Warning", content: "Error occurred", isError: true, color: ColorTheme.white);
        }
        Navigator.of(context).pop();
      }
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId;
  }

}