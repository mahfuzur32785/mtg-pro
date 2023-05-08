import 'package:flutter/material.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/values/strings.dart';

class MortgageCalculator extends StatefulWidget {
  const MortgageCalculator({Key? key}) : super(key: key);

  @override
  State<MortgageCalculator> createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          // changeLoading(progress) ;
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(mortgageUrl));

  void changeLoading(int progress) {
    if (isLoading && progress == 0) {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().simpleAppBar("Mortgage Calculator"),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
