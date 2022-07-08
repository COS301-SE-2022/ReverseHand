import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/blue_button_widget.dart';
import 'package:general/widgets/dialog_helper.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/actions/register_user_action.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/button.dart';
import '../widgets/circle_blur_widget.dart';
import '../widgets/divider.dart';
import '../widgets/link.dart';
import '../widgets/multiselect_widget.dart';
import '../widgets/otp_pop_up.dart';
import '../widgets/textfield.dart';
import 'location_page.dart';

class SignUpPage extends StatefulWidget {
  final Store<AppState> store;

   const SignUpPage({
    Key? key,
    required this.store
  }): super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // controllers for retrieveing text
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cellController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  // used for validation
  final _consumerFormKey = GlobalKey<FormState>();
  final _tradesmanFormKey = GlobalKey<FormState>();


  String? Function(String?) _createValidator(
      String kind, String invalidMsg, RegExp regex) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'A $kind must be entered';
      }

      if (!regex.hasMatch(value)) {
        return "${kind[0].toUpperCase() + kind.substring(1)} $invalidMsg";
      }

      return null;
    };
  }

  //used for multiselect for trade type
  List<String> selectedItems = [];

  void showMultiSelect() async {
    final List<String> items = [
      "Painter", 
      "Tiler", 
      "Carpenter",
      "Cleaner",
      "Designer",
      "Landscaper",
      "Electrician",
      "Plumber",
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectWidget(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        //*****************Tab View**********************
        home: DefaultTabController(
        length: 2,
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  const SliverAppBar(
                    backgroundColor: Color.fromRGBO(18, 26, 34, 1),
                    centerTitle: true,
                    title: Text( 
                      'SIGN UP', 
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 5,
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Color.fromRGBO(243, 157, 55, 1),
                      indicatorWeight: 5, 
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey, 
                      labelPadding: EdgeInsets.only(left: 50, right: 50),
                      tabs: [
                          //*****************Tabs**********************
                        Tab(child: Text(
                          'Contractor', 
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                        Tab(child: Text(
                          'Client', 
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                          //*******************************************
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  //*****************Tab Pages**********************

                  //*****************Tradesman SignUp**********************
                  Stack(
                    children: <Widget>[
                      //*****************Top circle blur**********************
                      const CircleBlurWidget(),
                      //*******************************************************

                      //*****************Bottom circle blur**********************
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleBlurWidget(),
                      ),
                      //******************************************************* */

                    //*****************signup page****************************
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //*****************form****************************
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: _tradesmanFormKey,
                                child: Column(
                                  children: <Widget>[
                                    //*****************name**********************
                                    TextFieldWidget(
                                      label: 'name',
                                      obscure: false,
                                      icon: Icons.account_circle_outlined,
                                      controller: nameController,
                                      // validator: _createValidator(
                                      //     "name",
                                      //     "must only be letters",
                                      //     RegExp(
                                      //         r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u")),
                                    ),
                                    //********************************************
                                    const TransparentDividerWidget(),
                                    //*****************email**********************
                                    TextFieldWidget(
                                      label: 'email',
                                      obscure: false,
                                      icon: Icons.alternate_email_outlined,
                                      controller: emailController,
                                      validator: _createValidator(
                                          'email',
                                          'is invalid',
                                          RegExp(
                                              r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************cellphone**********************
                                    TextFieldWidget(
                                      label: 'cellphone',
                                      obscure: false,
                                      icon: Icons.call_end_outlined,
                                      controller: cellController,
                                      validator: _createValidator('cellphone',
                                          'can only contain numbers', RegExp(r'')),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************location**********************
                                    TextFieldWidget(
                                      label: 'location',
                                      obscure: false,
                                      icon: Icons.add_location_outlined,
                                      controller: locationController,
                                      onTap: () async {
                                        const sessionToken = 1234;
                                        showSearch(
                                          context: context,
                                          delegate: AddressSearch(sessionToken, widget.store),
                                        );
                                      }
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************trade type**********************
                                    BlueButtonWidget(
                                      text: 'trade type',
                                        function: () => showMultiSelect(),
                                        width: 350,
                                        height: 60,
                                        icon: Icons.construction_outlined,
                                    ),

                                    // display selected items
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: selectedItems
                                        .map((types) => Chip(
                                          labelPadding: const EdgeInsets.all(2.0),
                                          label: Text(
                                            types,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: const Color.fromRGBO(35, 47, 62, 1),
                                          padding: const EdgeInsets.all(8.0),
                                        ))
                                      .toList(),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************password**********************
                                    TextFieldWidget(
                                      label: 'password',
                                      obscure: true,
                                      icon: Icons.lock_open_outlined,
                                      controller: passwordController,
                                      validator: _createValidator(
                                        'password',
                                        'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                                        RegExp(
                                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                                        ),
                                      ),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************confirm password**********************
                                    TextFieldWidget(
                                      label: 'confirm password',
                                      obscure: true,
                                      icon: Icons.lock_outline_rounded,
                                      controller: confirmController,
                                      validator: _createValidator(
                                        'password',
                                        'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                                        RegExp(
                                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                                        ),
                                      ),
                                    ),
                                    //**********************************************
                                  ],
                                ),
                              ),
                            ),
                            //****************************************************

                            //*****************signup button**********************
                            StoreConnector<AppState, _ViewModel>(
                              vm: () => _Factory(this),
                              builder: (BuildContext context, _ViewModel vm) =>
                                  LongButtonWidget(
                                text: "Sign Up",
                                login: () {
                                  if (_tradesmanFormKey.currentState!.validate()) {
                                    vm.dispatchSignUpAction(
                                      emailController.value.text.trim(),
                                      nameController.value.text.trim(),
                                      cellController.value.text.trim(),
                                      locationController.value.text.trim(),
                                      passwordController.value.text.trim(),
                                      true, // comment true for Consumer
                                    );

                                    DialogHelper.display(
                                      context,
                                      PopupWidget(
                                        store: widget.store,
                                      ),
                                    ); //trigger OTP popup
                                  }
                                },
                              ),
                            ),
                            //***************************************************

                            //*****************"OR" divider"**********************
                            SizedBox(
                              height: 30,
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: DividerWidget(),
                                  ),
                                  Text("or"),
                                  Expanded(
                                    child: DividerWidget(),
                                  ),
                                ],
                              ),
                            ),
                            //****************************************************** */

                            //*****************Sign in Link**********************
                            StoreConnector<AppState, _ViewModel>(
                              vm: () => _Factory(this),
                              builder: (BuildContext context, _ViewModel vm) =>
                                  LinkWidget(
                                text1: "Already have an account? ",
                                text2: "Sign In",
                                navigate: () => vm.pushLoginPage(),
                              ),
                            ),

                            //******************************************************* */
                            const Divider(
                              height: 20,
                              thickness: 0.5,
                              indent: 15,
                              endIndent: 10,
                              color: Colors.transparent,
                            ),
                            //*******************sign in with text************************** */
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    'or sign up with:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 12,
                                      color: Color(0x7df5fffa),
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                            //**********************************************************************/

                            //*******************sign in with image elements************************** */
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                      //Facebook
                                        GestureDetector(
                                        onTap: () {}, // Image tapped
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Image.asset(
                                            'assets/images/facebook.png',
                                            height: 100,
                                            width: 100,
                                            package: 'authentication',
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        //Google
                                        GestureDetector(
                                        onTap: () {}, // Image tapped
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image.asset(
                                            'assets/images/google.png',
                                            height: 100,
                                            width: 100,
                                            package: 'authentication',
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        //Apple
                                        //Shouldn't always display, figure out device being used: todo
                                        GestureDetector(
                                        onTap: () {}, // Image tapped
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.asset(
                                            'assets/images/apple.png',
                                            height: 100,
                                            width: 100,
                                            package: 'authentication',
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          //******************************************************* */
                          ],
                        ),
                      ),
                      //******************************************************* */
                    ],
                  ),
                    //******************************************************

                    //*****************Consumer SignUp**********************
                    Stack(
                    children: <Widget>[
                      //*****************Top circle blur**********************
                      const CircleBlurWidget(),
                      //*******************************************************

                      //*****************Bottom circle blur**********************
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleBlurWidget(),
                      ),
                      //******************************************************* */

                    //*****************signup page****************************
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //*****************form****************************
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: _consumerFormKey,
                                child: Column(
                                  children: <Widget>[
                                    //*****************name**********************
                                    TextFieldWidget(
                                      label: 'name',
                                      obscure: false,
                                      icon: Icons.account_circle_outlined,
                                      controller: nameController,
                                      // validator: _createValidator(
                                      //     "name",
                                      //     "must only be letters",
                                      //     RegExp(
                                      //         r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u")),
                                    ),
                                    //********************************************
                                    const TransparentDividerWidget(),
                                    //*****************email**********************
                                    TextFieldWidget(
                                      label: 'email',
                                      obscure: false,
                                      icon: Icons.alternate_email_outlined,
                                      controller: emailController,
                                      validator: _createValidator(
                                          'email',
                                          'is invalid',
                                          RegExp(
                                              r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************cellphone**********************
                                    TextFieldWidget(
                                      label: 'cellphone',
                                      obscure: false,
                                      icon: Icons.call_end_outlined,
                                      controller: cellController,
                                      validator: _createValidator('cellphone',
                                          'can only contain numbers', RegExp(r'')),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************location**********************
                                    BlueButtonWidget(
                                      text: 'location',
                                      function: () => showMultiSelect(), //change to location function
                                      width: 350,
                                      height: 60,
                                      icon: Icons.add_location_outlined,
                                    ),
                                    //**********************************************        
                                    const TransparentDividerWidget(),
                                    //*****************password**********************
                                    TextFieldWidget(
                                      label: 'password',
                                      obscure: true,
                                      icon: Icons.lock_open_outlined,
                                      controller: passwordController,
                                      validator: _createValidator(
                                        'password',
                                        'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                                        RegExp(
                                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                                        ),
                                      ),
                                    ),
                                    //**********************************************
                                    const TransparentDividerWidget(),
                                    //*****************confirm password**********************
                                    TextFieldWidget(
                                      label: 'confirm password',
                                      obscure: true,
                                      icon: Icons.lock_outline_rounded,
                                      controller: confirmController,
                                      validator: _createValidator(
                                        'password',
                                        'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                                        RegExp(
                                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                                        ),
                                      ),
                                    ),
                                    //**********************************************
                                  ],
                                ),
                              ),
                            ),
                            //****************************************************

                            //*****************signup button**********************
                            StoreConnector<AppState, _ViewModel>(
                              vm: () => _Factory(this),
                              builder: (BuildContext context, _ViewModel vm) =>
                                  LongButtonWidget(
                                text: "Sign Up",
                                login: () {
                                  if (_consumerFormKey.currentState!.validate()) {
                                    vm.dispatchSignUpAction(
                                      emailController.value.text.trim(),
                                      nameController.value.text.trim(),
                                      cellController.value.text.trim(),
                                      locationController.value.text.trim(),
                                      passwordController.value.text.trim(),
                                      true, // comment true for Consumer
                                    );

                                    DialogHelper.display(
                                      context,
                                      PopupWidget(
                                        store: widget.store,
                                      ),
                                    ); //trigger OTP popup
                                  }
                                },
                              ),
                            ),
                            //***************************************************

                            //*****************"OR" divider"**********************
                            SizedBox(
                              height: 30,
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: DividerWidget(),
                                  ),
                                  Text("or"),
                                  Expanded(
                                    child: DividerWidget(),
                                  ),
                                ],
                              ),
                            ),
                            //****************************************************** */

                            //*****************Sign in Link**********************
                            StoreConnector<AppState, _ViewModel>(
                              vm: () => _Factory(this),
                              builder: (BuildContext context, _ViewModel vm) =>
                                  LinkWidget(
                                text1: "Already have an account? ",
                                text2: "Sign In",
                                navigate: () => vm.pushLoginPage(),
                              ),
                            ),

                            //******************************************************* */
                            const Divider(
                              height: 20,
                              thickness: 0.5,
                              indent: 15,
                              endIndent: 10,
                              color: Colors.transparent,
                            ),
                            //*******************sign in with text************************** */
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    'or sign up with:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 12,
                                      color: Color(0x7df5fffa),
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                            //**********************************************************************/

                            //*******************sign in with image elements************************** */
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                      //Facebook
                                        GestureDetector(
                                        onTap: () {}, // Image tapped
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Image.asset(
                                            'assets/images/facebook.png',
                                            height: 100,
                                            width: 100,
                                            package: 'authentication',
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        //Google
                                        GestureDetector(
                                        onTap: () {}, // Image tapped
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image.asset(
                                            'assets/images/google.png',
                                            height: 100,
                                            width: 100,
                                            package: 'authentication',
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        //Apple
                                        //Shouldn't always display, figure out device being used: todo
                                        GestureDetector(
                                        onTap: () {}, // Image tapped
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.asset(
                                            'assets/images/apple.png',
                                            height: 100,
                                            width: 100,
                                            package: 'authentication',
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          //******************************************************* */
                          ],
                        ),
                      ),
                      //******************************************************* */
                    ],
                  ),
                    //******************************************************
                    //*****************************************************

                  //*******************************************************
                ],
              ),
            )),
          ),
          //*******************************************************
        ),
      );
    }
  }

// factory for view model
class _Factory extends VmFactory<AppState, _SignUpPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSignUpAction:
            (email, name, cell, location, password, isConsumer) => dispatch(
                RegisterUserAction(
                    email, name, cell, location, password, isConsumer)),
        pushLoginPage: () => dispatch(NavigateAction.pushNamed('/login')),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushLoginPage;
  final void Function(String, String, String, String, String, bool)
      dispatchSignUpAction;

  _ViewModel({
    required this.dispatchSignUpAction,
    required this.pushLoginPage,
  }); // implementing hashcode
}