import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wachat_new_package/config/custom_theme.dart';
import 'package:wachat_new_package/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';
import 'package:wachat_new_package/controller/wachat_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WachatScreen extends ConsumerStatefulWidget {
  final Function(InAppWebViewController controller)? onControllerLoad;
  final String url;
  const WachatScreen({super.key, this.onControllerLoad, required this.url});

  @override
  ConsumerState<WachatScreen> createState() => _WachatScreenState();
}

class _WachatScreenState extends ConsumerState<WachatScreen> {
  final GlobalKey webViewKey = GlobalKey();
  Timer? _timer;
  int _secondsLeft = 120;
  bool _paywallShown = false;

  final String iosUserAgent =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3312.0 Safari/537.36";

  final String androidUserAgent =
      "Mozilla/5.0 (Windows NT 10.0; Win32; x86) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36";

  InAppWebViewController? webViewController;
  InAppWebViewSettings options = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowFileAccessFromFileURLs: true,
    allowUniversalAccessFromFileURLs: true,
    useOnDownloadStart: true,
    pageZoom: 1.0,
    useShouldOverrideUrlLoading: true,
    supportZoom: false,
    userAgent:
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3312.0 Safari/537.36',
  );

  @override
  void initState() {
    super.initState();
    final isPremium = ref.read(isPremiumProvider);
    if (!isPremium) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _secondsLeft--;
      });
      if (_secondsLeft <= 0 && !_paywallShown) {
        _paywallShown = true;
        _timer?.cancel();
        _showPaywallAndExit();
      }
    });
  }

  void _showPaywallAndExit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('wachatTrialUsed', true);
    await RevenueCatService.showPaywallIfNeeded();
    GoRouter.of(context).go('/home');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Consumer(
          builder: (context, ref, _) {
            final isPremium = ref.watch(isPremiumProvider);
            final isBackDisabled = !isPremium && _secondsLeft > 0;
            return IconButton(
              icon: Image.asset(
                'assets/icons/chevron-left.png',
                width: width * 0.06,
                color: isBackDisabled ? Colors.grey : Colors.black,
              ),
              onPressed: isBackDisabled
                  ? null
                  : () => GoRouter.of(context).go('/home'),
            );
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.21),
          child: Text(
            'Wachat',
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.green),
          ),
        ),
        // Sayaç göstergesi
        actions: [
          Consumer(builder: (context, ref, _) {
            final isPremium = ref.watch(isPremiumProvider);
            if (!isPremium && _secondsLeft > 0) {
              return Padding(
                padding:  EdgeInsets.only(right:  width * 0.02),
                child: Center(
                  child: Container(
                    width: width * 0.2,
                    height: width * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    alignment: Alignment.center,
                    child: Text('$_secondsLeft sn',
                        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
        child: FutureBuilder<Object>(
            future: loadJavascript(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InAppWebView(
                  initialSettings: options,
                  key: webViewKey,
                  initialUserScripts: UnmodifiableListView<UserScript>([
                    UserScript(
                      source: snapshot.data.toString(),
                      injectionTime: UserScriptInjectionTime.AT_DOCUMENT_END,
                    ),
                  ]),
                  initialUrlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse('https://web.whatsapp.com/')),
                    // url: Uri.parse(widget.url),
                    headers: {
                      "User-Agent":
                          Platform.isAndroid ? androidUserAgent : iosUserAgent,
                    },
                  ),
                  onLoadStart: (controller, url) {},
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    // widget.onControllerLoad!(controller);
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    if (consoleMessage.message.contains('COPY_LOGIN_CODE')) {}
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (uri.host != Uri.parse(widget.url).host) {
                      launchUrl(uri);
                      return NavigationActionPolicy.CANCEL;
                    }

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        // Launch the App

                        await launchUrl(
                          uri,
                        );

                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }
                    return null;
                  },
                  onLoadStop: (controller, url) {},
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED,
                    );
                  },
                  // androidOnPermissionRequest: (controller, origin, resources) async {
                  //   return PermissionRequestResponse(
                  //     resources: resources,
                  //     action: PermissionRequestResponseAction.GRANT,
                  //   );
                  // },
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                  },
                  // onDownloadStartRequest: (controller, url) async {
                  //   await FlutterDownloader.enqueue(
                  //     url: url.url.toString(),
                  //     savedDir: (await getExternalStorageDirectory())!.path,
                  //     showNotification: true, // show download progress in status bar (for Android)
                  //     openFileFromNotification: true,
                  //     // click on notification to open downloaded file (for Android)
                  //   );
                  // },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
