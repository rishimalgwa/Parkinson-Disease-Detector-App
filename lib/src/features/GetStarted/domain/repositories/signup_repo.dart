import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pkd_app/src/common/api/urls.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/auth_req.dart';
import '../../data/models/auth_res.dart';

class SignupRepo {
  final Dio _dio = Dio();
  Future<Either<Failure, AuthResponse>> signup(AuthReq userData) async {
    String url = '$baseUrl/users/signup';

    try {
      final Response response = await _dio.post(url,
          data: authReqToJson(userData),
          options: Options(
            // followRedirects: false,
            // validateStatus: (status) {
            //   return status! < 500;
            // },
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
          ));

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> data = response.data as Map<String, dynamic>;
          log(data.toString());
          return Right(AuthResponse.fromJson(data));
        default:
          log(response.data.toString());
          return Left(UnidentifiedFailure());
      }
    } catch (e) {
      log(e.toString());
      if (e is DioError) {
        switch (e.response?.statusCode) {
          case 401:
            return Left(UnAuthenticatedFailure());
          case 500:
            return Left(ServerFailure());
          default:
            return Left(UnidentifiedFailure());
        }
      }

      return Left(UnidentifiedFailure());
    }
  }
}
