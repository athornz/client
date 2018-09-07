library upload_files.server;

import 'dart:async';
import 'package:http/http.dart' as ht;
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'server.dart';

part 'file_upload.jretro.dart';

/// Example showing how to define an [ApiClient]
@GenApiClient(path: "api")
class UserApi extends _$UserApiClient implements ApiClient {
  final Route base;

  final SerializerRepo serializers;

  UserApi({this.base, this.serializers});

  @PostReq(path: "upload")
  Future<StringResponse> upload(@AsMultipartField() MultipartFile file);
}

client() async {
  globalClient = ht.IOClient();
  StringResponse resp = await UserApi(base: route("http://localhost:8005"))
      .upload(MultipartFile([1, 2, 3, 4, 5], filename: "numbers.bytes"));
  print(resp.bytes);
}

main() async {
  await server();
  await client();
}
