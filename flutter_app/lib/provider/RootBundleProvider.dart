import 'package:flutter/services.dart' show rootBundle;

class RootBundleProvider {
  Future<String> loadJsonFile(String file) {
    return rootBundle.loadString(file);
  }
}
