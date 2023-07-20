import 'package:provider/provider.dart';
import '../View/Apis_integrate/apis_call.dart';
import '../View/LoginScreen/controller/login_provider.dart';
import '../View/MainPage/controller/provider_controller.dart';

var multiProvider = [
  ChangeNotifierProvider<MainScreenController>(
    create: (_) => MainScreenController(),
    lazy: true,
  ),
  ChangeNotifierProvider<LoginController>(
    create: (_) => LoginController(),
    lazy: true,
  ),
  ChangeNotifierProvider<LoginApis>(
    create: (_) => LoginApis(),
    lazy: true,
  ),
];
