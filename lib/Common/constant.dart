import 'package:flutter/material.dart';

const greyIconColor = Color(0xff999999);
const editBorderColor = greyIconColor;
const scaffoldBgColor = Colors.white;
const greyTextColor = Color(0xff999999);
const kBtnColor = Color(0xff4f37b3);

const TextStyle editTextStyle = TextStyle(fontSize: 16.0);
TextStyle titleTextStyle =  const TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal);
const convertWidgetToPng = "Convert Widget to Png";
const fillDetails = "Fill Details";
const filledDetails = "Filled Details";
const selectYourLogoImage = "Select Your Logo Image";
const selectYourBackgroundColor = "Select Your Background Color";
const kPageCardRadius = 42.0;
const imageDownloadSuccessfully="Image Download Successfully Check your Gallery";

showSnackBarMsg(BuildContext context, String msg){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '$msg',
      style: TextStyle(color: Colors.white),
    ),
  ));
}

