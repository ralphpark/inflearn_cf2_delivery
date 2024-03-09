

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inflearn_cf2_actual/common/const/data.dart';

class CustomInterceptor extends Interceptor {

  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  //1)요청 보낼때
  //요청이 보내질때마다
  //만약에 요청의 Header에 accessToken이 true로 되어있으면
  // 실제 토큰을 가져와서(sotrage에서) authorization:bearer $token으로
  // 헤더를 변경한다.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if(options.headers['accessToken'] == 'true'){
      //헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      //실제토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
      }

    if(options.headers['refreshToken'] == 'true'){
      //헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      //실제토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }


    return super.onRequest(options, handler);
    }
  //2)응답 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }
  //3)에러 발생시
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //401에러가 났을때(statusCode)
    //토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    //다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    final refreshToken =await storage.read(key: REFRESH_TOKEN_KEY);
    //토큰이 없으면 에러를 그대로 반환
    if(refreshToken == null){
      //에러를 던질때는 handler.reject를 사용한다.
      handler.reject(err);
      return;
    }
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if(isStatus401 && !isPathRefresh){
      final dio = Dio();

      try{
        final resp = await dio.post('http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );
        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        //토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        //요청 재전송
        final response = await dio.fetch(options);
        //응답 반환
        return handler.resolve(response);

      }on DioException catch(e){
        //토큰 재발급 실패
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}

