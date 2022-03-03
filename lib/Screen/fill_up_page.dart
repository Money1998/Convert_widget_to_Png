import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Common/constant.dart';
import 'package:untitled/Widget/CustomEditText.dart';

import 'diplay_filled_page.dart';

class FillUpPage extends StatefulWidget {
  const FillUpPage({Key? key}) : super(key: key);

  @override
  _FillUpPageState createState() => _FillUpPageState();
}

class _FillUpPageState extends State<FillUpPage> {
  Color pickerColor = Color(0xffffffff);
  Color currentColor = Color(0xffffffff);
  TextEditingController? nameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      addressController = TextEditingController();
  FocusNode? nameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      phoneNumFocusNode = FocusNode(),
      addressFocusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  File? _imageData;
  final GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

  final RegExp? _email = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  @override
  void initState() {
    // TODO: implement initState
    pickerColor = Color(0xffffffff);
    currentColor = Color(0xffffffff);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          title: const Text(fillDetails),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.04),
                child: SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          setLogo(height),
                          Divider(
                            height: height * 0.04,
                            thickness: 1,
                          ),
                          setBackGroundColor(height),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          CustomEditText(
                            controller: nameController,
                            validator: (String? args) {
                              if (args!.isEmpty) {
                                return 'Name is required';
                              } else {
                                return null;
                              }
                            },
                            hintText: 'Name',
                            textInputAction: TextInputAction.next,
                            onSubmit: (v) {
                              FocusScope.of(context)
                                  .requestFocus(nameFocusNode);
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomEditText(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (args) {
                              if (args.toString().isEmpty) {
                                return 'Email id is required';
                              } else if (!isEmail(args!)) {
                                return 'Enter valid email id';
                              } else {
                                return null;
                              }
                            },
                            onSubmit: (v) {
                              FocusScope.of(context)
                                  .requestFocus(emailFocusNode);
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomEditText(
                            controller: phoneNumberController,
                            focusNode: phoneNumFocusNode,
                            hintText: 'Phone Number',
                            inputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (args) {
                              if (args.toString().isEmpty) {
                                return 'Phone Number is required';
                              } else {
                                return null;
                              }
                            },
                            onSubmit: (v) {
                              FocusScope.of(context)
                                  .requestFocus(phoneNumFocusNode);
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomEditText(
                            controller: addressController,
                            focusNode: addressFocusNode,
                            hintText: 'Company Name',
                            inputType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (args) {
                              if (args.toString().isEmpty) {
                                return 'Address is required';
                              } else {
                                return null;
                              }
                            },
                            onSubmit: (v) {
                              FocusScope.of(context)
                                  .requestFocus(addressFocusNode);
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SizedBox(
                            width: width * 0.6,
                            height: height * 0.055,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey!.currentState!.validate()) {
                                  _next(
                                      currentColor,
                                      _imageData,
                                      nameController!.text,
                                      emailController!.text,
                                      phoneNumberController!.text,
                                      addressController!.text);
                                }
                              },
                              child: const Text("Next"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _next(
    Color? currentColor,
    File? imageData,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
  ) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayFilledPage(
                  currentColor: currentColor!,
                  imageData: imageData!,
                  name: name!,
                  email: email!,
                  phoneNumber: phoneNumber!,
                  address: address!,
                )));
  }

  Widget setLogo(double height) {
    return Column(
      children: [
        Text(selectYourLogoImage, style: titleTextStyle),
        SizedBox(
          height: height * 0.01,
        ),
        InkWell(
          onTap: () async {
            await _onImageButtonPressed(ImageSource.gallery, context: context);
          },
          child: _imageData != null
              ? CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 38.0,
                    backgroundImage: Image.file(
                      _imageData!,
                      fit: BoxFit.cover,
                    ).image,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                      child: Icon(
                        Icons.upload_outlined,
                        size: 50,
                        color: _imageData == null
                            ? Colors.black
                            : Colors.transparent,
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 38.0,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                      child: const Icon(
                        Icons.upload_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget setBackGroundColor(double height) {
    return Column(
      children: [
        Text(selectYourBackgroundColor, style: titleTextStyle),
        SizedBox(
          height: height * 0.01,
        ),
        InkWell(
          onTap: () {
            setState(() {
              colorPicker(context);
            });
          },
          child: CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 38.0,
              backgroundColor: currentColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                child: const Icon(
                  Icons.color_lens,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      var imageData = await _picker.pickImage(source: source);
      setState(() {
        _imageData = File.fromUri(Uri.parse(imageData!.path));
      });
    } catch (e) {
      setState(() {});
    }
  }

  bool isEmail(String str) {
    return _email!.hasMatch(str.toLowerCase());
  }

  Future<Widget?> colorPicker(BuildContext context) async => await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return AlertDialog(
          scrollable: true,
          titlePadding: const EdgeInsets.all(10.0),
          contentPadding: const EdgeInsets.all(10.0),
          content: Column(
            children: [
              ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: true,
                displayThumbColor: true,
                paletteType: PaletteType.hsv,
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                ),
                portraitOnly: true,
              ),
              SizedBox(
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        );
      });
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
