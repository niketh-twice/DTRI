import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';

class HotelGallery extends StatefulWidget {
  const HotelGallery({Key? key, this.images}) : super(key: key);
  final images;
  @override
  State<HotelGallery> createState() => _HotelGalleryState();
}

List<String> listOfUrls= [];

class _HotelGalleryState extends State<HotelGallery> {
  @override
  void initState() {
    setState(() {
      listOfUrls=widget.images;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: InkWell(
            onTap: () => Get.back(),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/icons/left-arrow.png'),
            radius: 15,
          ),
          //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                GalleryImage(
                  numOfShowImages: listOfUrls.length,
                  imageUrls: listOfUrls,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
