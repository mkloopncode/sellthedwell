import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';


class ImageScreen extends StatefulWidget {
  final List imageList;
  const ImageScreen({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        titleSpacing: -20,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios_new,color: ColorUtils.textColor),
            onPressed: () =>
                Navigator.pop(context,true)
        ),
        title: Container(
            child:  Text("Photo Gallery",style: TextStyles.appBarTitle,)/*Image.asset(
          Konstants.logoPath,
          height: 32,
        ),*/
        ), // Set this height
      ),
      body: Center(
        child: SizedBox(
          child: Stack(
            children: [
              CarouselSlider(
                carouselController: carouselController, // Give the controller
                options: CarouselOptions(
                  reverse: false,
                  padEnds: true,
                  autoPlay: false,
                ),
                items: widget.imageList.map((featuredImage) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Image.network(featuredImage)
                  );
                }).toList(),
              ),
              Positioned(
                  top: 100,
                  left: MediaQuery.of(context).size.width*.01,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        // Use the controller to change the current page
                        carouselController.previousPage();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  )),
              Positioned(
                top: 100,
                right: MediaQuery.of(context).size.width*.01,
                child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.nextPage();
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ),)

            ],
          ),
        ),
      ),
    );
  }
}
