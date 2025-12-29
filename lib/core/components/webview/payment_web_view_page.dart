import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';

class PaymentWebViewPage extends StatefulWidget {
  const PaymentWebViewPage({super.key, required this.payLink, this.backTo});

  final String payLink;
  final Function()? backTo;

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  InAppWebViewController? webViewController;

  // bool isError = false;

  // String currentUrl = 'login';

  late PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    _setPullRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool canGoBackValue = false;
  bool canGoForwardValue = false;
  final logEventDataScript = UserScript(
    groupName: 'userScripts',
    source: '''
      window.addEventListener('message', function(event) {
        if (event.data.type === 'logEvent') {
          console.log('Received event:', event.data);
        }
      });
        ''',
    injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
  );

  void backToFunction() {
    if (widget.backTo != null) {
      widget.backTo?.call();
    } else {
      context.navigateToPageWithClearStack(const LandingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('payment').tr(),
        leading: IconButton(
          onPressed: () {
            backToFunction();
          },
          icon: const AssetSvgImage(AssetImagesPath.backButtonSVG),
        ),
      ),
      body: Column(
        children: [
          // if (isLoading) const LinearProgressIndicator(),
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialUserScripts: UnmodifiableListView<UserScript>([
                    logEventDataScript,
                  ]),
                  initialUrlRequest: URLRequest(url: WebUri(widget.payLink)),
                  initialSettings: InAppWebViewSettings(
                    mediaPlaybackRequiresUserGesture: false,
                    // useHybridComposition: true,
                    allowsInlineMediaPlayback: true,
                    useShouldOverrideUrlLoading: true,
                    transparentBackground: true,
                  ),
                  onGeolocationPermissionsShowPrompt:
                      (InAppWebViewController controller, String origin) async {
                        return GeolocationPermissionShowPromptResponse(
                          origin: origin,
                          allow: true,
                          retain: true,
                        );
                      },
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {},
                  onLoadStart:
                      (InAppWebViewController controller, Uri? url) async {
                        canGoBackValue = await webViewController!.canGoBack();
                        canGoForwardValue = await webViewController!
                            .canGoForward();
                        // setState(() {});
                      },
                  shouldOverrideUrlLoading: shouldOverrideUrlLoading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// shouldOverrideUrlLoading: (controller, navigationAction) async {
  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final uri = navigationAction.request.url;

    /// api/v1/success
    if (uri!.path.contains('/success')) {
      'success_payment'.showTopSuccessToast;
      backToFunction();
      return NavigationActionPolicy.CANCEL;
    } else if (uri.path.contains('/fail')) {
      'fail_payment'.showTopErrorToast;
      backToFunction();
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  void _setPullRefresh() {
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(color: AppColors.cPrimary),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                await webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: await webViewController?.getUrl(),
                  ),
                );
              }
            },
          );
  }
}
