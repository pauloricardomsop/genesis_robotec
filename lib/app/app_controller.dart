import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/models/app_stream.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';

class AppController {
  static final AppController _instance = AppController._();

  AppController._();

  factory AppController() => _instance;

  //* Keys *//

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  //* Providers *//

  //* Controller *//

  //* IMPL *//

  final AppStream<List<ProductKit>> credential = AppStream<List<ProductKit>>();

  Future<void> onAppInit() async {
    // await getCredential();
  }

//   Future<Credential> getCredential() async {
//     final crd = await CredentialRepository.credential;
//     credential.add(crd);
//     return crd;
//   }

//   Future<void> addCredential(Credential crd) async {
//     await clearCredential();
//     await CredentialRepository.addCredential(crd);
//     await getCredential();
//   }

//   Future<void> clearCredential() async {
//     await CredentialRepository.clear();
//     await getCredential();
//   }
// }
}
