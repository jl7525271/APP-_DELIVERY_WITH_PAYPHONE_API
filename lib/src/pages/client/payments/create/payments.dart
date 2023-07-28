import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DynamicLinkViewer extends StatefulWidget {
  @override
  _DynamicLinkViewerState createState() => _DynamicLinkViewerState();
}

class _DynamicLinkViewerState extends State<DynamicLinkViewer> {
  String? redirectedUrl;

  Future<void> _openLink() async {
    const link = 'https://payp.page.link/8FQb';

    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'No se puede abrir el enlace: $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metodo de Pago'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _openLink,
            child: Text('PAYPHONE'),
          ),
          SizedBox(height: 20),
          if (redirectedUrl != null)
            Text('URL redirigida: $redirectedUrl')
          else
            Text('Esperando redirección...'),
          Expanded(
            child: InAppWebView(
              //initialUrlRequest: URLRequest(url: Uri.parse('about:blank')),
              onLoadStart: (controller,url) {
                setState(() {
                  redirectedUrl = url.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}