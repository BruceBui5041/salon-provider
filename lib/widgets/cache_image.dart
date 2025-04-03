import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/cookie_config.dart';

class CacheImageWidget extends StatefulWidget {
  final String? url;
  const CacheImageWidget({super.key, this.url});

  @override
  State<CacheImageWidget> createState() => _CacheImageWidgetState();
}

class _CacheImageWidgetState extends State<CacheImageWidget> {
  @override
  void initState() {
    CookieConfig.setCookieToApi(
        Uri.parse("https://d3i048dqjftjb3.cloudfront.net"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: widget.url ?? '',
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => Image.network(
        "https://placehold.co/600x400/png",
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
