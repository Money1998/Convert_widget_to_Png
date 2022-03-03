import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/Common/constant.dart';

// ignore: must_be_immutable
class DisplayFilledPage extends StatefulWidget {
  Color? currentColor;
  File? imageData;
  String? name, email, phoneNumber, address;

  DisplayFilledPage(
      {Key? key,
      this.currentColor,
      this.imageData,
      this.name,
      this.email,
      this.phoneNumber,
      this.address})
      : super(key: key);

  @override
  _DisplayFilledPageState createState() => _DisplayFilledPageState();
}

class _DisplayFilledPageState extends State<DisplayFilledPage> {
  Color currentColor = Color(0xffffffff);
  GlobalKey previewContainer = GlobalKey();
  TextEditingController? nameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      addressController = TextEditingController();
  File? _imageData;

  @override
  void initState() {
    // TODO: implement initState
    Permission.storage.request();
    currentColor = widget.currentColor!;
    _imageData = widget.imageData!;
    nameController!.text = widget.name!;
    emailController!.text = widget.email!;
    phoneNumberController!.text = widget.phoneNumber!;
    addressController!.text = widget.address!;
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
        backgroundColor: currentColor,
        appBar: AppBar(
          title: const Text(filledDetails),
          actions: [
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal:30),
                icon: const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  downloadImage();
                })
          ],
        ),
        body: RepaintBoundary(
          key: previewContainer,
          child: Container(
            color: currentColor,
            margin: EdgeInsets.only(top: height * 0.04),
            child: SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    setLogo(height),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Name : "),
                      Text(nameController!.text,style:titleTextStyle,)
                    ]),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Email ID : "),
                          Text(emailController!.text,style:titleTextStyle,)
                        ]),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("PhoneNumber : "),
                          Text(phoneNumberController!.text,style:titleTextStyle,)
                        ]),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Address : "),
                          Text(addressController!.text,style:titleTextStyle,)
                        ]),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  downloadImage() async{
      RenderRepaintBoundary? boundary = previewContainer.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage();
      Directory? tempDir = await getExternalStorageDirectory();
      final myImagePath = tempDir!.path;
      await Directory(myImagePath).create();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$myImagePath/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      var imagePath= await ImageGallerySaver.saveFile(imgFile.path);
      // ignore: avoid_print
      print(imagePath);
      showSnackBarMsg(context, imageDownloadSuccessfully);

  }


  Widget setLogo(double height) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 78.0,
            backgroundImage: Image.file(
              _imageData!,
              fit: BoxFit.cover,
            ).image,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
