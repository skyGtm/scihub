import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scihub/constants.dart';

// Widgets
import '../widgets/download_button.dart';
import '../widgets/error_info.dart';
import '../services/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearchButtonPressed = false;
  late TextEditingController _controller;
  var _activeUrl = baseUrls[0];

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SciHub Downloader'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('SciHub Downloader'),
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Utils.getAppInfo()),
                              SizedBox(height: 10),
                              Text('Uses Permisson: INTERNET'),
                              SizedBox(height: 10),
                              Text(Utils.getHelpInfo()),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Understood'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SciHub Links',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text('Active URLs', style: TextStyle(fontSize: 10)),
                      Text(
                        'Change active URL as needed',
                        style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.5,
                    // height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: List.generate(
                        baseUrls.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _activeUrl = baseUrls[index];
                              });
                            },
                            child: RadioListTile(
                              title: Text(baseUrls[index].toUpperCase()),
                              value: baseUrls[index],
                              groupValue: _activeUrl,
                              onChanged: (newValue) {
                                setState(() {
                                  _activeUrl = baseUrls[index];
                                });
                              },
                              activeColor: Colors.blueAccent,
                              // selectedTileColor: Colors.grey.shade600,
                            ),
                          );
                        },
                        growable: false,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Enter article URL',
                  labelStyle: klabelTextStyle,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _controller.clear(),
                  ),
                ),
                controller: _controller,
                style: TextStyle(fontSize: 18),
                minLines: 1,
                maxLines: 4,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      isSearchButtonPressed = true;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Enter a valid Url',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
                child: Text('Search'),
              ),
              SizedBox(
                height: 30,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),
              ),
              FutureBuilder(
                future: isSearchButtonPressed
                    ? Utils().getDownloadLink(
                        baseUrl: _activeUrl,
                        docUrl: _controller.text,
                      )
                    : null,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    isSearchButtonPressed = false;
                    return DownloadButton(downloadUrl: snapshot.data);
                  } else if (snapshot.hasError) {
                    isSearchButtonPressed = false;
                    return ErrorInfo(
                        info:
                            'Unavailable or Invalid Url\nTry different base url from above.');
                  }
                  return isSearchButtonPressed
                      ? Center(child: CircularProgressIndicator())
                      : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
