import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewWidget extends StatefulWidget {
  final LoadingBuilder loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final PageController pageController;
  final List<String> galleryItems;
  final Axis scrollDirection;

  PhotoViewWidget({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController();

  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  int currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider:
                              NetworkImage(widget.galleryItems[index]),
                          initialScale: PhotoViewComputedScale.contained,
                          heroAttributes: PhotoViewHeroAttributes(tag: index),
                        );
                      },
                      itemCount: widget.galleryItems.length,
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes,
                          ),
                        ),
                      ),
                      backgroundDecoration: widget.backgroundDecoration,
                      pageController: widget.pageController,
                      scrollDirection: widget.scrollDirection,
                      onPageChanged: (val) {
                        setState(() {
                          currentIndex = val;
                        });
                      },
                    ),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.white
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            Text(
                              "${currentIndex + 1}/${widget.galleryItems.length}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                decoration: null,
                              ),
                            ),
                          ],
                        )),
                  ],
                ))));
  }
}
