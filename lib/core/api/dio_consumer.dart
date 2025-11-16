import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lo2tah/core/api/api_consumer.dart';
import 'package:lo2tah/core/api/app_interceptors.dart';
import 'package:lo2tah/core/api/end_points.dart';
import 'package:lo2tah/core/api/status_codes.dart';

import '../../app/service_locator.dart';
import '../../config/log/logger.dart';
import '../errors/exceptions.dart';
import '../utils/strings_manager.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate certificate, String host, int port) => true;
      return httpClient;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCodes.badRequest;
      };

    client.interceptors.add(serviceLocator<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(serviceLocator<LogInterceptor>());
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useAccessToken = false,
    required BuildContext context,
  }) async {
    try {
      client.options.headers['lang'] = context.locale.languageCode;
      client.options.headers['Accept'] = AppStrings.applicationJson;
      if (useAccessToken) {
        client.options.headers['Authorization'] = 'Bearer ';
      }
      final response = await client.get(path, queryParameters: queryParameters);
      return response;
    } catch (error) {
      _handleDioError(context, error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    bool useAccessToken = false,
    required BuildContext context,
  }) async {
    try {
      client.options.headers['lang'] = context.locale.languageCode;
      client.options.headers['Accept'] = AppStrings.applicationJson;
      if (useAccessToken) {
        client.options.headers['Authorization'] = 'Bearer ';
      }

      if (formDataIsEnabled) {
        Logger.print(title: 'Form Data Enabled');
        client.options.headers[AppStrings.contentType] = AppStrings.multiPart;
      } else {
        client.options.headers[AppStrings.contentType] =
            AppStrings.applicationJson;
      }
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );

      return response;
    } catch (error) {
      _handleDioError(context, error);
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool useAccessToken = false,
    required BuildContext context,
  }) async {
    try {
      client.options.headers['lang'] = context.locale.languageCode;
      client.options.headers['Accept'] = AppStrings.applicationJson;
      if (useAccessToken) {
        client.options.headers['Authorization'] = 'Bearer ';
      }
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } catch (error) {
      _handleDioError(context, error);
    }
  }

  @override
  Future download(BuildContext context, String url, String savePath) async {
    try {
      final response = await client.download(url, savePath);
      return response;
    } catch (error) {
      _handleDioError(context, error);
    }
  }

  dynamic _handleDioError(BuildContext context, error) {
    if (error is Exception) {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            throw const FetchDataException();
          case DioExceptionType.cancel:
            throw const RequestCancelledException();
          case DioExceptionType.badCertificate:
            throw const BadRequestException();
          case DioExceptionType.connectionError:
            throw const NoInternetConnectionException();
          case DioExceptionType.unknown:
            throw const UnExpectedErrorException();
          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case StatusCodes.badRequest:
                throw const BadRequestException();
              case StatusCodes.forbidden:
              case StatusCodes.unAuthorized:
                SystemNavigator.pop();
              case StatusCodes.notFound:
                throw const NotFoundException();
              case StatusCodes.methodNotAllowed:
                throw const MethodNotAllowedException();

              case StatusCodes.conflict:
                throw const ConflictException();

              case StatusCodes.requestTimeOut:
                throw const FetchDataException();

              case StatusCodes.unProcessableEntity:
                throw ResponseException(
                  json.decode(error.response?.data)['message'],
                );

              case StatusCodes.internalServerError:
                throw const InternalServerErrorException();

              case StatusCodes.serviceUnavailable:
                throw const ServiceUnavailableException();

              default:
                throw const UnExpectedErrorException();
            }
        }
      } else if (error is SocketException) {
        throw const NoInternetConnectionException();
      } else {
        throw const UnExpectedErrorException();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        throw const UnableToProcessException();
      } else {
        throw UnExpectedErrorException(error.toString());
      }
    }
  }
}
