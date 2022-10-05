import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class InitBack4app {
  InitBack4app() {
    // init();
  }

  Future<bool> init() async {
    const keyApplicationId = '41khDEwc9OeEDclYQ9UnT2HEmysZ2E5JG5534qsp';
    const keyClientKey = 'Ha2Cr0rF2iHTCiJFyeadmwMY6wTVmDw4R9W2Mu6O';
    const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      debug: true,
    );
    return (await Parse().healthCheck()).success;
  }
}
