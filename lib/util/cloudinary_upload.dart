import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:sales_app/shared/constant.dart';

import 'connection.dart';

class CloudinaryUpload {
  Future<String> uploadToCloudinary(String imagepath) async {
    final Connection checkConnection = Connection();
    final bool connect = await checkConnection.initConnectivity();
    final cloudinary =
        Cloudinary(cloudinaryAPIKey, cloudinaryAPISecret, cloudinaryCloud);
    if (connect) {
      final CloudinaryResponse response = await cloudinary.uploadFile(
        filePath: imagepath,
        resourceType: CloudinaryResourceType.image,
        folder: "test/falcon",
      );
      return response.url.toString();
    } else {
      return "false";
    }
  }
}
