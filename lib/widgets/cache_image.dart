import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/config/cookie_config.dart';
import 'package:fixit_provider/config/storage_config.dart';
import 'package:flutter/material.dart';

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
    return FutureBuilder(
        future: StorageConfig.readList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else if (snapshot.data == null) {
            return const Icon(Icons.error, color: Colors.red);
          }

          return CachedNetworkImage(
            httpHeaders: {
              'Set-Cookie': snapshot.data![0], // add your cookie here
            },
            fit: BoxFit.cover,
            imageUrl: widget.url ?? '',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Image.network(
              "https://placehold.co/600x400/png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          );
        });
  }
}
