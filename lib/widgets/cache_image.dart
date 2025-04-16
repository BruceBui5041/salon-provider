import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/cookie_config.dart';

class CacheImageWidget extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CacheImageWidget(
      {super.key, this.url, this.width, this.height, this.fit = BoxFit.cover});

  @override
  State<CacheImageWidget> createState() => _CacheImageWidgetState();
}

class _CacheImageWidgetState extends State<CacheImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CachedNetworkImage(
        fit: widget.fit ?? BoxFit.cover,
        imageUrl: widget.url ?? '',
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => Image.network(
          "https://placehold.co/600x400/png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
