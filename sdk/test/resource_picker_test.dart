import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/functionality/resource_picker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('test 1: ', () async {
    ResourcePicker resourcePicker = new ResourcePicker("client_id", "client_secret", "enterprise_id", "redirect_url", testing: 1);
    expect(resourcePicker.resourcePickerURL, "https://accounts.google.com/o/oauth2/auth?client_id=client_id&redirect_uri=redirect_url&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service&state=state");
    expect(await resourcePicker.askForAuthorization(), "authorization successful");
    expect(resourcePicker.accessToken, "accessTokenTest");
  });
}