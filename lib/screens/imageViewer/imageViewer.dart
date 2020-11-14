import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class OriaImageView extends StatefulWidget {
  final String url;
  OriaImageView({this.url});
  @override
  OriaImageViewState createState() => OriaImageViewState();
}

class OriaImageViewState extends State<OriaImageView> {
  PhotoViewScaleStateController scaleStateController;
  @override
  void initState() {
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 249, 249, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(color: Colors.black),
        child: Hero(
          tag: 'image-view',
          child: GestureDetector(
            onVerticalDragEnd: (DragEndDetails dragEndDetails) => {
              if (dragEndDetails.primaryVelocity > 100.0)
                {Navigator.of(context).pop()}
            },
            // onVerticalDragDown: (DragDownDetails downDetails) {
            //   print(downDetails.globalPosition);
            //   print(downDetails.localPosition);
            //   Navigator.of(context).pop();
            // },
            child: PhotoView(
                // initialScale: 1.0,
                enableRotation: false,
                tightMode: true,
                scaleStateController: scaleStateController,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained,
                imageProvider: widget.url != null
                    ? NetworkImage(
                        widget.url,
                      )
                    : AssetImage(
                        "assets/images/person_placeholder.png",
                      )),
          ),
        ),
      ),
    );
  }
}
