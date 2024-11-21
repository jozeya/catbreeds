
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:catbreeds/models/catbreed.dart';


const String serverURL = "https://api.thecatapi.com/v1";
const String apiKEY = "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr";

class CatBreedService{

  final HttpClient httpClient;

  CatBreedService() : httpClient = HttpClient();

  Future<List<CatBreed>> getCatBreedInfoList({String? filter}) async{
    final url = Uri.parse('$serverURL/breeds');

    try{
      final request = await httpClient.getUrl(url);
      // request.headers.set('x-api-key', apiKEY);

      final response = await request.close();

      if (response.statusCode == 200){
        final responseBody = await response.transform(utf8.decoder).join();
        List<dynamic> result = jsonDecode(responseBody);

        if (filter!.isEmpty){
          return result.map((e) => CatBreed.fromJson(e)).toList();
        }else{
          print(filter);
          return [(result.map((e) => CatBreed.fromJson(e)).toList())
              .firstWhere((e) => e.name?.toLowerCase() == filter)];
        }
      }
      return [];
    }catch(e){
      return [];
    }
  }

  Future<String> getCatBreedImagePath(String id) async{
    final url = Uri.parse('$serverURL/images/search?breed_ids=$id');
    print('$serverURL/images/search?breed_ids=$id');
    try{
      final request = await httpClient.getUrl(url);
      // request.headers.set('x-api-key', apiKEY);

      final response = await request.close();

      if (response.statusCode == 200){
        final responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> result = jsonDecode(responseBody)[0];
        return result['url'];
      }
      return "";
    }catch(e){
      return "";
    }
  }

}