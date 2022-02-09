import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:elomia_test/models/result.dart';
import 'package:flutter/services.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/io_client.dart';

class GlobalConstants {
  static String messagesUrl = 'https://elomia.com/testTask.json';
}

class Network {
  Network() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // print(result);
    });
  }

  static final sharedInstance = Network();
  StreamSubscription<ConnectivityResult>? subscription;

  final Result<bool> _noInternetConnection =
      Result(false, errorMessage: 'No connection to the Internet');

  Future<Result<bool>> checkInternetConnection() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException {
      return _noInternetConnection;
    }
    if (result != ConnectivityResult.none) {
      return Result(true);
    } else {
      return _noInternetConnection;
    }
  }

  Future<Result<List<types.Message>?>> getMessages() async {
    return checkInternetConnection().then((value) async {
      if (value.success!) {
        HttpClient client = HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
        final httpClient = IOClient(client);
        // final uuid = await BlocProvider.instance.configurationBloc.getUuid();
        try {
          final url = Uri.parse(GlobalConstants.messagesUrl);
          final response = await httpClient.get(url);
          
          if ([200, 204].contains(response.statusCode) &&
              response.body.isNotEmpty) {
            
            try {
              final List<types.TextMessage>? messages = (jsonDecode(
                      response.body))['chatHistory']
                  ?.map((e) {

                    return types.TextMessage(
                        author: types.User(id: e['author']),
                        id: (jsonDecode(response.body)['chatHistory'] as List)
                            .indexWhere((element) => mapEquals(element, e))
                            .toString(),
                        text: e['text'] as String,
                        metadata: e['reaction'] != null
                            ? {'reaction': reactionTransformer(e['reaction'])}
                            : null);
                  })
                  .cast<types.TextMessage>()
                  .toList();

              return Result(true, value: messages?.reversed.toList());
            } catch (e) {
              return Result(false,
                  errorMessage:
                      'failed to get data with code [${response.statusCode}]');
            }
          } else {
            return Result(false,
                errorMessage:
                    'failed to get data with code [${response.statusCode}]');
          }
        } catch (e) {
          return Result(false, errorMessage: 'connection: ${e.toString()}');
        }
      } else {
        return Result(false, errorMessage: 'No connection to the Internet');
      }
    });
  }
}

enum Reaction { like, dislike, notSet }

Reaction reactionTransformer(String reaction) {
  switch (reaction) {
    case 'like':
      return Reaction.like;
    case 'dislike':
      return Reaction.dislike;
    default:
      return Reaction.notSet;
  }
}
