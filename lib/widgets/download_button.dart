import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scihub/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({required this.downloadUrl});

  // final VoidCallback onTap;
  final String downloadUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Download Link Found',
              style: kDownloadLinkTextStyle,
            ),
            SizedBox(height: 10),
            Text('$downloadUrl'),
            SizedBox(height: 10),
            Text(
              'Click Here to Download',
              style: kDownloadHintTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl() async => await canLaunch(this.downloadUrl)
      ? await launch(this.downloadUrl)
      : Fluttertoast.showToast(
          msg: 'Cannot launch Url: ${this.downloadUrl}',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.red,
        );
}
