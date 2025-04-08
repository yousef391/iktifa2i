import 'dart:convert';
import 'dart:io';
import 'package:greenhood/core/plant.dart';
import 'package:http/http.dart' as http;

Future<AnalyzePlantResponse?> analyzePlant({
  required File imageFile,
  required String plantType,
}) async {
  var uri = Uri.parse('http://127.0.0.1:8000/analyze-plant/');
  var request = http.MultipartRequest('POST', uri);

  request.fields['plant_type'] = plantType;
  request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return AnalyzePlantResponse.fromJson(jsonData);
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
