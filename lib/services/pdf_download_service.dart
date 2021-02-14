import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class DowloadPath {
  final String url =
      'https://www.xeroxscanners.com/downloads/Manuals/XMS/PDF_Converter_Pro_Quick_Reference_Guide.RU.pdf';
}

class PdfDownloadService {
  Future<bool> hasFile() async {
    return http
        .get(DowloadPath().url)
        .then((response) => response.statusCode == 200);
  }

  Future<String> downloadInvoice({
    BuildContext context,
  }) async {
    final date = DateFormat('LLLL yyyy').format(DateTime.now());
    final filename = '$date.pdf';

    final file = await DefaultCacheManager().getSingleFile(DowloadPath().url);
    final filePath = file.dirname + Platform.pathSeparator + filename;
    final renamedFile = await file.rename(filePath);

    return renamedFile.path;
  }
}
