import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pkd_app/src/common/api/urls.dart';
import 'package:pkd_app/src/features/Exercise/data/models/exercise_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';

class ExerciseRepo {
  final Dio _dio = Dio();
  Future<Either<Failure, ExerciseResponse>> fetch(String score) async {
    String url = '$baseUrl/samples';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? userID = prefs.getString('USER_ID');
    try {
      final Response response = await _dio.get(url,
          data: json.encode({"userID": userID, "score": score}),
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
          return Right(ExerciseResponse.fromJson(data));
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
