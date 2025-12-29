// import 'package:nakha/core/components/screen_status/loading_widget.dart';
// import 'package:nakha/core/components/utils/widgets.dart';
// import 'package:nakha/core/enum/enums.dart';
// import 'package:nakha/core/extensions/navigation_extensions.dart';
// import 'package:nakha/core/extensions/shared_extensions.dart';
// import 'package:nakha/core/extensions/widgets_extensions.dart';
// import 'package:nakha/core/res/app_images.dart';
// import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
// import 'package:nakha/features/landing/presentation/pages/landing_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SocialLoginRow extends StatelessWidget {
//   const SocialLoginRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.loginWithSocialRequestState == RequestState.error) {
//           (state.loginWithSocialResponse.msg ?? '').showTopErrorToast;
//         } else if (state.loginWithSocialRequestState == RequestState.loaded) {
//           (state.loginWithSocialResponse.msg ?? '').showTopSuccessToast;
//           context.navigateToPageWithClearStack(const LandingPage());
//         }
//       },
//       builder: (context, state) {
//         return state.loginWithSocialRequestState == RequestState.loading
//             ? const LoadingWidget()
//             : Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(AssetImagesPath.google).addAction(
//                   // onTap: () async {
//                   //   // To prevent replay attacks with the credential returned from Apple, we
//                   //   // include a nonce in the credential request. When signing in with
//                   //   // Firebase, the nonce in the id token returned by Apple, is expected to
//                   //   // match the sha256 hash of `rawNonce`.
//                   //   final rawNonce = generateNonce();
//                   //   final nonce = MostUsedFunctions.sha256ofString(rawNonce);
//                   //
//                   //   // Request credential for the currently signed in Apple account.
//                   //   final appleCredential =
//                   //       await SignInWithApple.getAppleIDCredential(
//                   //     scopes: [
//                   //       AppleIDAuthorizationScopes.email,
//                   //       AppleIDAuthorizationScopes.fullName,
//                   //     ],
//                   //     nonce: nonce,
//                   //     webAuthenticationOptions: WebAuthenticationOptions(
//                   //       clientId: 'com.umrahhplus.service-id',
//                   //       redirectUri: Uri.parse(
//                   //         'https://umrahhplus.com/auth/apple/app-callback',
//                   //       ),
//                   //     ),
//                   //   );
//                   //
//                   //   MostUsedFunctions.printFullText(
//                   //     'Apple Credential: ${appleCredential.identityToken}',
//                   //   );
//                   //   MostUsedFunctions.printFullText(
//                   //     'Apple Authorization Code: ${appleCredential.authorizationCode}',
//                   //   );
//                   //   // MostUsedFunctions.copyToClipboardAndShowSnackBarFun(
//                   //   //   appleCredential.authorizationCode,
//                   //   // );
//                   //
//                   //   MostUsedFunctions.printFullText(
//                   //     'Apple Email: ${appleCredential.email}',
//                   //   );
//                   //   MostUsedFunctions.printFullText(
//                   //     'Apple Full Name: ${appleCredential.givenName} ${appleCredential.familyName}',
//                   //   );
//                   //   MostUsedFunctions.printFullText(
//                   //     'Apple User: ${appleCredential.email}',
//                   //   );
//                   //
//                   //   // Create an `OAuthCredential` from the credential returned by Apple.
//                   //   final oauthCredential =
//                   //       OAuthProvider('apple.com').credential(
//                   //     idToken: appleCredential.identityToken,
//                   //     rawNonce: rawNonce,
//                   //   );
//                   //   LoginBloc.get(context).add(
//                   //     LoginWithSocialButtonPressedEvent(
//                   //       SocialLoginParameters(
//                   //         provider: SocialProvidersEnum.apple.name,
//                   //         accessProviderToken: null,
//                   //         code: appleCredential.authorizationCode,
//                   //         email: appleCredential.email,
//                   //         fullName:
//                   //             '${oauthCredential.appleFullPersonName?.givenName ?? ''} ${oauthCredential.appleFullPersonName?.familyName ?? ''}',
//                   //       ),
//                   //     ),
//                   //   );
//                   // },
//                 ),
//                 16.sizedWidth,
//                 const AssetSvgImage(AssetImagesPath.appleSVG).addAction(
//                   // onTap: () async {
//                   //   const List<String> scopes = <String>[
//                   //     'email',
//                   //     'https://www.googleapis.com/auth/contacts.readonly',
//                   //   ];
//                   //
//                   //   final GoogleSignIn googleSignIn = GoogleSignIn(
//                   //     // Optional clientId
//                   //     clientId: Platform.isAndroid
//                   //         ? null
//                   //         : '1083862707766-4uas7rh1bpe556egiksck3q330v2fc3a.apps.googleusercontent.com',
//                   //     scopes: scopes,
//                   //   );
//                   //
//                   //   await googleSignIn.signOut();
//                   //
//                   //   final GoogleSignInAccount? googleUser =
//                   //       await googleSignIn.signIn();
//                   //
//                   //   if (googleUser != null) {
//                   //     final GoogleSignInAuthentication googleAuth =
//                   //         await googleUser.authentication;
//                   //     MostUsedFunctions.printFullText(
//                   //       'Google ID Token: ${googleAuth.idToken}',
//                   //     );
//                   //     if (googleAuth.accessToken != null) {
//                   //       LoginBloc.get(context).add(
//                   //         LoginWithSocialButtonPressedEvent(
//                   //           SocialLoginParameters(
//                   //             provider: SocialProvidersEnum.google.name,
//                   //             accessProviderToken: googleAuth.accessToken,
//                   //             email: googleUser.email,
//                   //             fullName: googleUser.displayName ?? 'no name',
//                   //             code: null,
//                   //           ),
//                   //         ),
//                   //       );
//                   //     }
//                   //   }
//                   // },
//                 ),
//               ],
//             );
//       },
//     );
//   }
// }
