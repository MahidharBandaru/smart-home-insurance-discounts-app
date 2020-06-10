import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/services/access_devices.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

MockClient mockClient;
MockResponse mockResponse;
AccessDevices accessDevices;

const String getAllDevicesUrl =
    "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterprise-id/devices";
const String getDevicesOfStructureUrl =
    "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterprise-id/structures/structure-id/devices";
const String getAllStructuresUrl =
    "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterprise-id/structures";
const String getDeviceStatusUrl =
    "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterprise-id/devices/device-id";

const deviceResponse =
    '{"name" : "/enterprises/enterprise-id/devices/device-id","type" : "sdm.devices.types.device-type","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}}}';
const allDevicesListResponse = '{ "devices": [' + deviceResponse + '] }';
const devicesOfStructureListResponse =
    '{ "devices": [' + deviceResponse + '] }';
const allStructuresListResponse =
    '{"structures": [{"name": "enterprises/sdm-internal/structures/AVPHwEtfUkCviHmeFD_OR4HNMExGmuPENGmG_9BsP5C-05EWFbrQpgZV5laMe8GhMiyg3XXTbI5AvTzzYUoQ03Zd6pQ8","traits": {"sdm.structures.traits.Info": {"customName": "Second home"}}},{"name": "enterprises/sdm-internal/structures/AVPHwEvTILTn3tYCarertyG3cExQYAdHxF5xhVSDf5eQc6F8gi4ThQDGirY7_n-XzYcs9DQChQ8obbUihc0h2YWg5EDy","traits": {"sdm.structures.traits.Info": {"customName": "Onyx Home"}}}]}';

const device = {
  'id': 'device-id',
  'customName': null,
  'type': 'sdm.devices.types.device-type'
};
const allDevicesResult = [device];
const devicesOfStructureResult = [device];
const allStructuresResult = [
  {
    'id':
        'AVPHwEtfUkCviHmeFD_OR4HNMExGmuPENGmG_9BsP5C-05EWFbrQpgZV5laMe8GhMiyg3XXTbI5AvTzzYUoQ03Zd6pQ8',
    'customName': {'customName': 'Second home'}
  },
  {
    'id':
        'AVPHwEvTILTn3tYCarertyG3cExQYAdHxF5xhVSDf5eQc6F8gi4ThQDGirY7_n-XzYcs9DQChQ8obbUihc0h2YWg5EDy',
    'customName': {'customName': 'Onyx Home'}
  }
];

void main() {
  // Default setup
  setUp(() {
    mockClient = new MockClient();
    mockResponse = new MockResponse();
    when(mockClient.post(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.post(getAllStructuresUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.post(getDeviceStatusUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.post(getDevicesOfStructureUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));

    accessDevices = new AccessDevices(mockClient, "enterprise-id",
        accessDevicesTimeoutDuration: new Duration(milliseconds: 100));
    print("setting access token");
    accessDevices.setAccessToken("accessToken");
  });

  test("test 1.1: get all devices successful http request", () async {
    // defining behaviour
    when(mockResponse.body).thenReturn(allDevicesListResponse);

    // testing
    expect((await accessDevices.getAllDevices()).value, allDevicesResult);
  });

  test("test 1.2: get all devices exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.post(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getAllDevices()).isEmpty, true);
  });

  test("test 1.3: get all devices timeout on http request", () async {
    // Defining behaviour: returns a response after 200 ms
    when(mockClient.post(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    }); // Mock response returns a body
    when(mockResponse.body).thenReturn(allDevicesListResponse);

    // testing
    expect((await accessDevices.getAllDevices()).isEmpty, true);
  });

  test("test 2.1: get all structures successful http request", () async {
    // Defining behaviour
    when(mockResponse.body).thenReturn(allStructuresListResponse);

    // testing
    expect((await accessDevices.getAllStructures()).value, allStructuresResult);
  });

  test("test 2.2: get all structures exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.post(getAllStructuresUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getAllStructures()).isEmpty, true);
  });

  test(
      "test 2.3: get all structures returns response on http request in 200 ms",
      () async {
    // Defining behaviour: throws error
    when(mockClient.post(getAllStructuresUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockResponse.body).thenReturn("list of structures");

    // testing
    expect((await accessDevices.getAllStructures()).isEmpty, true);
  });

  test("test 3.1: get device status successful http request", () async {
    // Defining behaviour
    when(mockResponse.body).thenReturn(deviceResponse);

    // testing
    expect((await accessDevices.getDeviceStatus("device-id")).value, "ONLINE");
  });

  test("test 3.2: get devices status exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.post(getDeviceStatusUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getDeviceStatus("device-id")).isEmpty, true);
  });

  test(
      "test 3.3: get devices status returns response on http request in 200 ms",
      () async {
    // defining behaviour
    when(mockClient.post(getDeviceStatusUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockResponse.body).thenReturn(deviceResponse);

    // testing
    expect((await accessDevices.getDeviceStatus("device-id")).isEmpty, true);
  });

  test("test 4.1: get devices of structure successful http request", () async {
    // defining behaviour
    when(mockResponse.body).thenReturn(devicesOfStructureListResponse);

    // testing
    expect((await accessDevices.getDevicesOfStructure('structure-id')).value,
        devicesOfStructureResult);
  });

  test("test 4.2: get devices of structure exception on http request",
      () async {
    // Defining behaviour: throws error
    when(mockClient.post(getDevicesOfStructureUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getDevicesOfStructure('structure-id')).isEmpty,
        true);
  });

  test("test 4.3: get devices of structure timeout on http request", () async {
    // Defining behaviour: returns a response after 200 ms
    when(mockClient.post(getDevicesOfStructureUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    }); // Mock response returns a body
    when(mockResponse.body).thenReturn(devicesOfStructureListResponse);

    // testing
    expect((await accessDevices.getDevicesOfStructure('structure-id')).isEmpty,
        true);
  });
}
