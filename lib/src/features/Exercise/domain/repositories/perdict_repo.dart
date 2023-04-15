import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:pkd_app/src/common/api/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';

class PredictRepo {
  final Dio _dio = Dio();
  Future<Either<Failure, Map<String, dynamic>>> predict(
      String sampleID, String filePath, String fileName, File file) async {
    String url = '$baseUrl/predict';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userID = prefs.getString('USER_ID');
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://parkisnons.onrender.com/predict/'));
      request.fields.addAll({'sampleID': sampleID, 'userID': userID!});
      request.headers["Content-Type"] = 'multipart/form-data';

      request.files.add(
        http.MultipartFile.fromBytes("predictImage", (await file.readAsBytes()),
            filename: 'pkd_image.png', contentType: MediaType('image', 'png')),
      );

      http.StreamedResponse response = await request.send();

      switch (response.statusCode) {
        case 200:
          return Right(json.decode(await response.stream.bytesToString()));
        case 201:
          return Right(json.decode(await response.stream.bytesToString()));
        case 500:
          return Left(ServerFailure());
        default:
          //  log(response.data.toString());
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
