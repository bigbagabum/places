import 'package:flutter/material.dart';

class ImageGallery extends StatefulWidget {
  final List<String> imgList;
  const ImageGallery({super.key, required this.imgList});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(fit: StackFit.loose, children: [
        PageView.builder(
          itemCount: widget.imgList.length,
          onPageChanged: (int pageNum) {
            setState(() {
              _currentPage = pageNum;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              widget.imgList[index],
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            );
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth *
                    (_currentPage + 1) /
                    widget.imgList.length,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(3),
                      topRight: Radius.circular(3)),
                  color: Theme.of(context).primaryColorLight,
                ),
              );
            }),
          ],
        )
      ]),
    );
  }
}
