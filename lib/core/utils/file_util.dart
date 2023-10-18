import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as date;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../app/data/constant/save_file_exception.dart';

Future<String> writeAndSaveFile({required String content, required String fileName}) async {
  // Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  // String? appDocumentsPath = appDocumentsDirectory?.path;
  // String filePath = '$appDocumentsPath/$fileName.csr';
  String filePath = '/storage/emulated/0/Download/$fileName.csr';
  File file = File(filePath);
  file.writeAsString(content);
  return "Đã lưu file vào mục Download";
}

///Phương thức để save một file to cache disk
///return về một path file.
Future<String> writeFileToCache({required ByteData data, String? folder, required String fileName}) async {
  final buffer = data.buffer;
  File file = await initFileToCache(fileName: fileName, folder: folder);
  await file.writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  return file.path;
}

///Phương thức để save chuỗi String vào file và lưu trong cache
///return về một đường dẫn đến file.
Future<String> writeStringFileToCache({required String data, String? folder, required String fileName}) async {
  File file = await initFileToCache(fileName: fileName, folder: folder);
  await file.writeAsString(data);
  return file.path;
}

///Phương thức init một file rỗng nằm trong cache folder
Future<File> initFileToCache({required String fileName, String? folder}) async {
  final directory = await getTemporaryDirectory();
  final path = directory.path;
  return folder == null ? File('$path/$fileName') : File('$path/$folder/$fileName');
}

///Lấy địa chỉ thư mục cache của ứng dụng
Future<String> getCacheDirectory() async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

String getTimeVnNow() {
  DateTime now = DateTime.now();
  return date.DateFormat("dd-MM-yyy hh:mm:ss").format(now);
}

String getDateVnNow() {
  DateTime now = DateTime.now();
  return date.DateFormat("dd-MM-yyyy").format(now);
}

String getDateVn1MonthLater() {
  DateTime now = DateTime.now();
  DateTime monthLater = DateTime(now.year, now.month + 1, now.day, now.hour, now.minute, now.second);
  return date.DateFormat("dd-MM-yyyy hh:mm:ss").format(monthLater);
}

///Phương thức dùng để load data của file, được lưu giữ trong asset folder của flutter
///return List<int>, parameter là String pathFile: path của image file được khai báo trong pubspec.yaml
Future<List<int>> readDataFromAsset(String pathFile) async {
  final ByteData data = await rootBundle.load(pathFile);
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

///Phương thức lấy data của một file khi biết đường dẫn của file được lưu trên disk của driver.
///return Uint8List, parameter là path của file được lưu trong disk của driver
Future<Uint8List?> readDataFile(String path) async {
  try {
    final file = File(path);
    final contents = await file.readAsBytes();
    return contents;
  } catch (e) {
    return null;
  }
}

///Phương thức lấy data của một file khi biết đường dẫn của file được lưu trên disk của driver.
///return String, parameter là path của file được lưu trong disk của driver
Future<String?> readStringDataFile(String path) async {
  try {
    final file = File(path);
    final contents = await file.readAsString();
    return contents;
  } catch (e) {
    return "";
  }
}

Future<List<int>> readDocumentData(String name, [bool isImage = false]) async {
  final ByteData data = await rootBundle.load(isImage ? 'assets/images/$name' : 'assets/certs/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

///Phương thức để ghi một file khi đã có dữ liệu của file đó vào disk mà chỉ được ứng dụng quản lý.
///file này chỉ được xóa khi ứng dụng bị xóa khỏi thiết bị. lưu ý extension phải trùng với extension của file gốc
/// khi đọc để lấy được ByteData data.
Future<File> writeFileApplicationDocumentsDirectory(ByteData data, fileName) async {
  final buffer = data.buffer;
  Directory appDir = await getApplicationDocumentsDirectory();
  String appDirPath = appDir.path;
  var filePath = '$appDirPath/$fileName';
  return File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

Future<String?> deleteFileFromCache(String path) async {
  final file = File(path);
  try {
    await file.delete();
    return "Success!";
  } catch (_) {
    await file.delete();
    return "Error delete!";
  }
}

///Phương thức để get text size.
Size getTextSize(String text, TextStyle style) {
  final TextPainter textPainter =
  TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}

extension GetOrrientation on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional  "#".leading
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
  //'${alpha.toRadixString(16).padLeft(2, '0')}'// dòng them ff trước color vd: #ff44a349 nếu không có thì color=#44a349
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

///Create một folder và return path
Future<String> createFolder({required folderName}) async {
  final dir = Directory((Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
  )!
      .path +
      '/$folderName');
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await dir.exists())) {
    return dir.path;
  } else {
    dir.create();
    return dir.path;
  }
}

///Chuyển chuỗi String dạng base64 thành file pdf và lưu vào máy (không phải lưu vào cache)
Future<String> saveBase64ToFile(String base64String, String fileName) async {
  final encodedStr = base64String;
  Uint8List bytes = base64.decode(encodedStr);
  Directory? dir =
  Platform.isAndroid ? Directory('/storage/emulated/0/Download') : await getApplicationDocumentsDirectory();
  debugPrint("$dir");

  File file =
  File("${dir.path}/${fileName.substring(0, fileName.indexOf("."))}_${DateTime.now().millisecondsSinceEpoch}.pdf");
  String statusAsString = "";

  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    //Nếu đường đẫn đến folder Download không hợp lệ, thì lưu vào folder ứng dụng
    if (!await dir.exists()) {
      dir = await getExternalStorageDirectory();
    }

    //Lấy version của android
    int androidVersion = int.parse(androidInfo.version.release);

    //Kiểm tra yêu cầu truy cập bộ nhớ cho thiết bị đang dùng hệ điều hành android 13 hoặc lớn hơn
    if (androidVersion >= 13) {
      PermissionStatus result = await Permission.photos.request();
      result.isGranted
          ? statusAsString = SaveFileExceptions.granted
          : result.isDenied
          ? statusAsString = SaveFileExceptions.denied
          : statusAsString = SaveFileExceptions.limited;
    }
    //Kiểm tra yêu cầu truy cập bộ nhớ cho thiết bị đang dùng hệ điều hành android 12 hoặc nhỏ hơn
    else {
      PermissionStatus result = await Permission.storage.request();
      result.isGranted
          ? statusAsString = SaveFileExceptions.granted
          : result.isDenied
          ? statusAsString = SaveFileExceptions.denied
          : statusAsString = SaveFileExceptions.limited;
    }
  } else {
    //Kiểm tra yêu cầu truy cập bộ nhớ cho thiết bị đang dùng hệ điều hành IOS
    PermissionStatus result = await Permission.storage.request();
    debugPrint("$result");
    result.isGranted
        ? statusAsString = SaveFileExceptions.granted
        : result.isDenied
        ? statusAsString = SaveFileExceptions.denied
        : statusAsString = SaveFileExceptions.limited;
  }

  if (statusAsString == SaveFileExceptions.denied) {
    return SaveFileExceptions.permitError;
  } else if (statusAsString == SaveFileExceptions.granted) {
    try {
      await file.writeAsBytes(bytes);
      return SaveFileExceptions.success;
    } catch (e) {
      print(e);
      return SaveFileExceptions.saveError;
    }
  } else {
    return SaveFileExceptions.saveError;
  }
}

///Tạo một folder TRONG CACHE và return path
Future<String> createCacheFolder({required folderName}) async {
  final tempDir = await getTemporaryDirectory();
  final dir = Directory('${tempDir.path}/$folderName');
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await dir.exists())) {
    return dir.path;
  } else {
    dir.create();
    return dir.path;
  }
}

///Lưu chuỗi uint8list thành file và trả về địa chỉ lưu file
Future<String> writeUint8listFileToCache({required Uint8List uint8list, required String fileName}) async {
  final tempDir = await getTemporaryDirectory();
  final saveFile = await File('${tempDir.path}/temp/$fileName').create();
  saveFile.writeAsBytes(uint8list);
  return saveFile.path;
}

///Xóa một folder TRONG CACHE và return path
void clearCacheFolder({required folderName}) async {
  final tempDir = await getTemporaryDirectory();
  final dir = Directory('${tempDir.path}/$folderName');
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  dir.deleteSync(recursive: true);
  dir.create();
}
