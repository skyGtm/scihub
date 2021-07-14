import 'dart:io';
import 'package:chaleno/chaleno.dart';

class Utils {
  // final String docUrl = "https://ieeexplore.ieee.org/document/4839587/";
  // final String baseUrl = 'https://sci-hub.st/';

  Future<String> getDownloadLink(
      {required String baseUrl, required String docUrl}) async {
    var link;

    final _url = 'https://$baseUrl/$docUrl';
    // await Future.delayed(
    //     Duration(milliseconds: 1000),
    //     () => {
    //           link =
    //               'https://moscow.sci-hub.st/3448/ec78671d26e8c5b2e68761d63185ee0c/etters2009.pdf'
    //         });
    // return link;

    // print('BaseUrl: $baseUrl');
    // print('DocUrl: $docUrl');
    // print('Final Url: $_url');

    try {
      var parser = await Chaleno().load(_url);
      if (parser != null) {
        var result = parser.getElementsByTagName('iframe');
        if (result != null) {
          link = result[0].src?.split('#')[0];
          print('Link Found = $link');
        } else {
          print("Result = $result");
        }
      }
      if (link.startsWith('//')) {
        return 'https:' + link;
      } else
        return link;
    } on SocketException catch (error) {
      throw error;
    }
  }

  static String getAppInfo() {
    String t1 = 'Unofficial App to download research papers from Sci-Hub.\n';
    String t2 =
        'Paste the article URL available from https://ieeexplore.ieee.org/ ';
    String t3 = 'and may other research paper websites.\n';
    String t4 = 'This app fetches the direct download link from the Sci-Hub.';

    return t1 + t2 + t3 + t4;
  }

  static String getHelpInfo() {
    return 'If the app doesnot work, try using VPN and try again.';
  }
}
