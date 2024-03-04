import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inflearn_cf2_actual/common/component/custom_text_form_field.dart';
import 'package:inflearn_cf2_actual/common/const/colors.dart';
import 'package:inflearn_cf2_actual/common/const/data.dart';
import 'package:inflearn_cf2_actual/common/layout/default_layout.dart';
import 'package:inflearn_cf2_actual/common/view/root_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();


    //local host
    final emulatorIP = '10.0.0.2:3000';
    final simulatorIP = '127.0.0.1:3000';

    final ip = Platform.isAndroid ? emulatorIP : simulatorIP;

    return DefaultLayout(
        child:SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  const SizedBox(height: 16),
                  _SubTitle(),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width/3 * 2,
                  ),
                  CustomTextFormField(
                    hintText: '이메일을 입력해주세요',
                    onChanged: (String value) {
                      username = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요',
                    onChanged: (String value) {
                      password = value;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      //id:비밀번호
                      final rawString = '$username:$password';
                      //base64로 인코딩
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      String token = stringToBase64.encode(rawString);

                      //에뮬레이터 IP : 10.0.0.2:3000
                      //시뮬레이터 IP : 127.0.0.1:3000

                      final resp = await dio.post('http://$ip/auth/login',
                          options: Options(
                            headers: {
                              'authorization' : 'Basic $token',
                            },
                          ),
                      );

                      final refreshToken = resp.data['refreshToken'];
                      final accessToken = resp.data['accessToken'];
                      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);


                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RootTab(),
                        )
                      );
                    },
                    child: Text('로그인', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  TextButton(
                    //회원가입 버튼 클릭 시 리프레쉬 토큰을 통한 액세스토큰 발급으로 실습
                    onPressed: () async{
                      final refreshToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTcwOTUzMjU3MCwiZXhwIjoxNzA5NjE4OTcwfQ._zjXyOy05VOCaEDGp1P_9ZpUACAv4hbuWi7gzLUJS7c';

                      final resp = await dio.post('http://$ip/auth/token',
                        options: Options(
                          headers: {
                            'authorization' : 'Bearer $refreshToken',
                          },
                        ),
                      );
                      print(resp.data);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,),
                    child: Text('회원가입'),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n오늘도 성공적인 주문이 되길;)',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

