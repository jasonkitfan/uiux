import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widget/course_category.dart';
import '../custom_widget/my_app_bar.dart';
import '../data_manager/provider.dart';
import '../global_function/func.dart';
import 'hd_page.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  static const route = "/application";

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double offset = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xff7874ff),
        title: MyAppBar(
          scaffoldKey: scaffoldKey,
        ),
        automaticallyImplyLeading: false,
      ),
      drawer: SizedBox(width: width * 2 / 3, child: const CourseCategory()),
      body: !isRunningOnWindow()
          ? const Body()
          : Listener(
              onPointerSignal: (signal) {
                if (signal is PointerScrollEvent) {
                  offset += signal.scrollDelta.dy;
                  _scrollController.animateTo(offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    offset = _scrollController.offset;
                  }
                  return true;
                },
                child: Body(controller: _scrollController),
              ),
            ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key, this.controller}) : super(key: key);

  final ScrollController? controller;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final formSpacing = 30.0;
  Gender gender = Gender.male;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => Provider.of<CourseDetailProvider>(context, listen: false)
            .getCourse());
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    idController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void popDialog(String course, String email) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Success"),
              content: Text(
                  "Your application for $course is completed. The receipt will be sent to your email address $email"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, HDPage.route),
                  child: const Text("Confirm"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CourseDetailProvider>(context);
    if (provider.courseTitle == null || provider.courseImage == null) {
      return const Center(child: CircularProgressIndicator());
    }

    double width = getWidth(context);
    Responsive screenSize = responsive(width);

    return SingleChildScrollView(
      controller: widget.controller,
      physics:
          isRunningOnWindow() ? const NeverScrollableScrollPhysics() : null,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xffFAF3F0),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: 1000,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(provider.courseImage!),
                const SizedBox(height: 30),
                Text(
                  provider.courseTitle!,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                          controller: firstNameController,
                          labelText: "First Name"),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomInputField(
                          controller: lastNameController,
                          labelText: "Last Name"),
                    )
                  ],
                ),
                SizedBox(height: formSpacing),
                CustomInputField(
                    controller: idController, labelText: "ID Card"),
                SizedBox(height: formSpacing),
                const Align(
                    alignment: Alignment.centerLeft, child: Text("Gender")),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text("Male"),
                        leading: Radio<Gender>(
                          value: Gender.male,
                          groupValue: gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text("Female"),
                        leading: Radio<Gender>(
                          value: Gender.female,
                          groupValue: gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    if (screenSize != Responsive.small)
                      const Expanded(
                        flex: 3,
                        child: SizedBox(),
                      )
                  ],
                ),
                SizedBox(height: formSpacing),
                CustomInputField(
                    controller: emailController, labelText: "Email"),
                SizedBox(height: formSpacing),
                CustomInputField(
                    controller: phoneController, labelText: "Phone No."),
                SizedBox(height: formSpacing),
                CustomInputField(
                    controller: addressController, labelText: "Address"),
                SizedBox(height: formSpacing),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        bool valid = _formKey.currentState!.validate();
                        if (valid) {
                          popDialog(
                              provider.courseTitle!, emailController.text);
                        }
                      },
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Apply"))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Gender { male, female }

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {Key? key, required this.controller, required this.labelText})
      : super(key: key);
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: labelText),
      validator: (value) {
        if (value == null || value == "") {
          return 'Please enter this field';
        }
        return null;
      },
      onChanged: (val) {
        controller.text = val;
      },
    );
  }
}
