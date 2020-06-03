library sdk;

import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart';


class urlMaker{
  String _accessToken;
  String _refreshToken;
  String _clientId;
  String _clientSecret;
  String _resourcePickerURL;
  List<String> _scope;
  String EnterpriseId;
  String PCM_url="https://nestservices.google.com/partnerconnections";
  String redirect_URL ="urn:ietf:wg:oauth:2.0:oob";
   String url ;


  urlMaker(String clientId, String clientSecret, List<String> scope, String enterpriseId) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
    this._scope = scope;
    this.enterpriseId = enterpriseId;
    url ="$PCM_url/enterpriseId/auth?client_id=$_clientId&redirect_uri=$redirect_URL&response_type=code&scope=$_scope&state=state";
    Uri.parse(url);
  }

  Future<String> askForAuthorization() async {
    var authClient = await _launchResourcePicker(_resourcePickerURL);
    _accessToken = authClient.credentials.accessToken.data;
    _refreshToken = authClient.credentials.refreshToken.data;
  }

  Future<dynamic> _launchResourcePicker(String resourcePickerURL) async {
    var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret), _scope, (url) {
      launch(url);
    });
    return authClient;
  }
  String get accessToken {
    return _accessToken;
  }
}