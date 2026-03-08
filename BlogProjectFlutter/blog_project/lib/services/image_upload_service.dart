import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class ImageUploadService {
  static const String uploadUrl =
      'https://blog-backend-kf3i.onrender.com/api/upload';

  Future<String?> uploadImage(File imageFile) async {
    try {
      final uri = Uri.parse(uploadUrl);
      final request = http.MultipartRequest('POST', uri);

      final mimeType = _getMimeType(imageFile.path);
      final file = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      );

      request.files.add(file);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        // Simple parsing - in a real app, you'd want proper JSON parsing
        if (responseData.contains('imageUrl')) {
          final startIndex = responseData.indexOf('"imageUrl":"') + 11;
          final endIndex = responseData.indexOf('"', startIndex);
          if (startIndex > 10 && endIndex > startIndex) {
            return responseData.substring(startIndex, endIndex);
          }
        }
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
