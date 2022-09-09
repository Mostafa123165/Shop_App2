import 'package:shopapp2/model/model_login.dart';

abstract class MainLoginClass {}

 class InitialLoginState extends MainLoginClass{}

 class SuccessLoginState extends MainLoginClass{
  final ModelLogin? modelLogin ;

  SuccessLoginState(this.modelLogin);

 }

 class ErrorLoginState extends MainLoginClass{
    final String error ;
    ErrorLoginState(this.error);
 }

 class LoadingLoginState extends MainLoginClass{}

