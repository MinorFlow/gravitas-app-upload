import 'package:gravitas_app/common/models/comment_info_model.dart';
import 'package:gravitas_app/common/models/event_simple_model.dart';
import 'package:gravitas_app/common/models/horizon_info_model.dart';
import 'package:gravitas_app/common/models/planet_info_model.dart';
import 'package:gravitas_app/common/models/post_detail_model.dart';
import 'package:gravitas_app/common/models/post_simple_model.dart';

import '../models/request_login_model.dart';
import '../models/user_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

const String host = '218.236.34.34';
const String port = '3003';

class APIHelper {
  Future<bool> requestRegister(String id, String pw, String nickname) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/register');
    final param = {
      'id': id,
      'pw': pw,
      'nickname': nickname
    };
    final response = await http.post(url, body: param);
    try {
      result = jsonDecode(response.body)['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<RequestLoginModel> requestLogin(String id, String pw) async {
    final url = Uri.http('$host:$port', 'api/login');
    final encodedPW = sha256.convert(utf8.encode(pw)).toString();
    final param = {
      'id': id,
      'pw': encodedPW
    };
    final response = await http.post(url, body: param);
    return RequestLoginModel.fromJson(jsonDecode(response.body));
  }

  Future<UserInfoModel> getUserInfo(String token) async {
    final url = Uri.http('$host:$port', 'api/getuserinfo');
    final param = {
      'token': token
    };
    final response = await http.post(url, body: param);
    return UserInfoModel.fromJson(jsonDecode(response.body));
  }

  Future<bool> checkID(String id) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/checkid');
    final param = {
      'id': id,
    };
    final response = await http.post(url, body: param);
    try {
      result = jsonDecode(response.body)['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<bool> createPlanet(String token, String name, String desc) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/createplanet');
    final param = {
      'token': token,
      'name': name,
      'desc': desc
    };
    final response = await http.post(url, body: param);
    try {
      result = jsonDecode(response.body)['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<bool> createHorizon(String token, String name, String desc, int type, String pUID) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/createhorizon');
    final param = {
      'token': token,
      'name': name,
      'desc': desc,
      'type': '$type',
      'pUID': pUID
    };
    final response = await http.post(url, body: param);
    try {
      result = jsonDecode(response.body)['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<List<PlanetInfoModel>> getPlanetList() async {
    List<PlanetInfoModel> result = [];
    final url = Uri.http('$host:$port', 'api/getplanetlist');
    final response = await http.post(url);
    try {
      var suc = jsonDecode(response.body);
      var data = suc['data'];
      for (var planet in data) {
        result.add(PlanetInfoModel.fromJson(planet));
      }
    } catch(e) {
      // error
    }
    return result;
  }

  Future<List<HorizonInfoModel>> getHorizonList(String planetUID) async {
    List<HorizonInfoModel> result = [];
    final url = Uri.http('$host:$port', 'api/gethorizonlist');
    final param = {
      'planet_uid': planetUID,
    };
    final response = await http.post(url, body: param);
    try {
      var suc = jsonDecode(response.body);
      var data = suc['data'];
      for (var horizon in data) {
        result.add(HorizonInfoModel.fromJson(horizon));
      }
    } catch(e) {
      // error
    }
    return result;
  }

  Future<List<PostSimpleModel>> getPostList(int type, String uid) async {
    List<PostSimpleModel> result = [];
    final url = Uri.http('$host:$port', 'api/getpostlist');
    final param = {
      'type': '$type',
      'uid': uid,
    };
    final response = await http.post(url, body: param);
    try {
      var suc = jsonDecode(response.body);
      var data = suc['data'];
      for (var post in data) {
        result.add(PostSimpleModel.fromJson(post));
      }
    } catch(e) {
      // error
    }
    return result;
  }

  Future<List<PostSimpleModel>> getPostListAll() async {
    List<PostSimpleModel> result = [];
    final url = Uri.http('$host:$port', 'api/getpostlistall');
    final response = await http.post(url);
    try {
      var suc = jsonDecode(response.body);
      var data = suc['data'];
      for (var post in data) {
        result.add(PostSimpleModel.fromJson(post));
      }
    } catch(e) {
      // error
    }
    return result;
  }

  Future<PostDetailModel?> getPostDetail(String uid) async {
    PostDetailModel? result;
    final url = Uri.http('$host:$port', 'api/getpostdetail');
    final param = {
      'uid': uid,
    };
    final response = await http.post(url, body: param);
    try {
      var suc = jsonDecode(response.body);
      if (suc['success']) {
        var data = suc['data'];
        result = PostDetailModel.fromJson(data);
      }
    } catch(e) {
      // error
      result = null;
    }
    return result;
  }

  Future<bool> writePost(String token, int type, String uid, String title, String content) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/writepost');
    final param = {
      'token': token,
      'type': '$type',
      'uid': uid,
      'title': title,
      'content': content
    };
    try {
      final response = await http.post(url, body: param);
      var suc = jsonDecode(response.body);
      result = suc['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<List<CommentInfoModel>> getCommentList(String uid) async {
    List<CommentInfoModel> result = [];
    final url = Uri.http('$host:$port', 'api/getcommentlist');
    final param = {
      'uid': uid,
    };
    final response = await http.post(url, body: param);
    try {
      var suc = jsonDecode(response.body);
      if (suc['success']) {
        var data = suc['data'];
        for (var comment in data) {
          result.add(CommentInfoModel.fromJson(comment));
        }
      }
    } catch(e) {
      // error
    }
    return result;
  }

  Future<bool> writeComment(String token, String uid, String content) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/writecomment');
    final param = {
      'token': token,
      'uid': uid,
      'content': content
    };
    try {
      final response = await http.post(url, body: param);
      var suc = jsonDecode(response.body);
      result = suc['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<bool> createEvent(String token, String uid, String title, String desc, String location, String date) async {
    bool result = false;
    final url = Uri.http('$host:$port', 'api/createevent');
    final param = {
      'token': token,
      'uid': uid,
      'title': title,
      'desc': desc,
      'location': location,
      'date': date
    };
    try {
      final response = await http.post(url, body: param);
      var suc = jsonDecode(response.body);
      result = suc['success'];
    } catch(e) {
      result = false;
    }
    return result;
  }

  Future<List<EventSimpleModel>> getEventList(String uid) async {
    List<EventSimpleModel> result = [];
    final url = Uri.http('$host:$port', 'api/geteventlist');
    final param = {
      'uid': uid,
    };
    final response = await http.post(url, body: param);
    try {
      var suc = jsonDecode(response.body);
      if (suc['success']) {
        var data = suc['data'];
        for (var comment in data) {
          result.add(EventSimpleModel.fromJson(comment));
        }
      }
    } catch(e) {
      // error
    }
    return result;
  }
}