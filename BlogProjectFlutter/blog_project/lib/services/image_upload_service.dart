import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class ImageUploadService {
  static const String uploadUrl =
      'https://blog-backend-kf3i.onrender.com/api/upload';

  Future<String?> uploadImage(File imageFile) async {
    try {
      print('Image upload: Starting upload for file: ${imageFile.path}');
      print('Image upload: File size: ${imageFile.lengthSync()} bytes');

      final uri = Uri.parse(uploadUrl);
      final request = http.MultipartRequest('POST', uri);

      // Use 'file' as field name to match React frontend
      final mimeType = _getMimeType(imageFile.path);
      print('Image upload: Detected MIME type: $mimeType');

      final file = await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      );

      request.files.add(file);
      print('Image upload: File added to request with field name "file"');

      final response = await request.send();
      print('Image upload: Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        print('Image upload: Response body: $responseData');

        // Try to parse as JSON first
        try {
          final jsonMap = jsonDecode(responseData);
          print('Image upload: Parsed JSON: $jsonMap');

          // Try different possible field names
          if (jsonMap.containsKey('imageUrl')) {
            final imageUrl = jsonMap['imageUrl'];
            print('Image upload: Found imageUrl: $imageUrl');
            return imageUrl;
          } else if (jsonMap.containsKey('url')) {
            final imageUrl = jsonMap['url'];
            print('Image upload: Found url: $imageUrl');
            return imageUrl;
          } else if (jsonMap.containsKey('secure_url')) {
            final imageUrl = jsonMap['secure_url'];
            print('Image upload: Found secure_url: $imageUrl');
            return imageUrl;
          } else if (jsonMap.containsKey('image_url')) {
            final imageUrl = jsonMap['image_url'];
            print('Image upload: Found image_url: $imageUrl');
            return imageUrl;
          } else {
            print('Image upload: No known image URL field found in response');
            print('Image upload: Available keys: ${jsonMap.keys}');
          }
        } catch (jsonError) {
          print('Image upload: JSON parsing failed: $jsonError');
          // Fallback to string parsing
          if (responseData.contains('imageUrl')) {
            final startIndex = responseData.indexOf('"imageUrl":"') + 11;
            final endIndex = responseData.indexOf('"', startIndex);
            if (startIndex > 10 && endIndex > startIndex) {
              final imageUrl = responseData.substring(startIndex, endIndex);
              print(
                'Image upload: Found imageUrl via string parsing: $imageUrl',
              );
              return imageUrl;
            }
          } else if (responseData.contains('url')) {
            final startIndex = responseData.indexOf('"url":"') + 7;
            final endIndex = responseData.indexOf('"', startIndex);
            if (startIndex > 6 && endIndex > startIndex) {
              final imageUrl = responseData.substring(startIndex, endIndex);
              print('Image upload: Found url via string parsing: $imageUrl');
              return imageUrl;
            }
          }
        }
      } else {
        final errorBody = await response.stream.bytesToString();
        print('Image upload: Upload failed with status ${response.statusCode}');
        print('Image upload: Error body: $errorBody');
      }

      return null;
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  String _getMimeType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      default:
        return 'image/jpeg'; // Default fallback
    }
  }
}
