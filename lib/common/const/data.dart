import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final storage = FlutterSecureStorage();

//local host
final emulatorIP = '10.0.0.2:3000';
final simulatorIP = '127.0.0.1:3000';

final ip = Platform.isAndroid ? emulatorIP : simulatorIP;