import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/model/model_login.dart';
import 'package:shopapp2/modules/login/login_state.dart';
import 'package:shopapp2/shared/components/constant.dart';
import 'package:shopapp2/shared/network/end_points.dart';
import 'package:shopapp2/shared/network/local/cash_helper.dart';
import 'package:shopapp2/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<MainLoginClass> {

  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  ModelLogin? modelLogin ;
  void userLogin({required String email ,required String password,context }){
    emit(LoadingLoginState());
    DioHelper.posDate(
        url:LOGIN ,
        data:{
          "email":email,
          "password":password,
        },
    ).then((value) => {
      modelLogin = ModelLogin.formJson(value.data),
      token = modelLogin!.data!.token,
      CashHelper.saveData(key: "loginScreen", val: true),
      emit(SuccessLoginState(modelLogin!)),
    }).catchError((error){
      emit(ErrorLoginState(error.toString()));
      print(error.toString()) ;

    });
  }


}