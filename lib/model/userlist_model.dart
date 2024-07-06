/// status : true
/// message : "Success"
/// userList : [{"id":1,"first_name":"Mohit","last_name":"Prajapati","email":"mohit@gmail.com","country_code":"+91","phone_no":"1326458790","status":"1"},{"id":2,"first_name":"Mohit","last_name":"Prajapati","email":"mohitprajapati@mmfinfotech.in","country_code":"+91","phone_no":"1234567890","status":"1"},{"id":3,"first_name":"e","last_name":"e","email":"e@mail.com","country_code":"+91","phone_no":"9876543210","status":"1"},{"id":4,"first_name":"e","last_name":"e","email":"o@mail.com","country_code":"+91","phone_no":"9876543210","status":"1"},{"id":5,"first_name":"test","last_name":"test","email":"c@mail.com","country_code":"+91","phone_no":"9876543210","status":"1"},{"id":6,"first_name":"test","last_name":"test","email":"a@mail.com","country_code":"+91","phone_no":"9876543210","status":"1"},{"id":7,"first_name":"Mohit","last_name":"Prajapati","email":"mohit.prajapati@mmfinfotech.in","country_code":"+91","phone_no":"1234567890","status":"1"},{"id":8,"first_name":"mohit","last_name":"prajapat","email":"mohit@mmfinfotech.in","country_code":"+91","phone_no":"01234567890","status":"1"},{"id":9,"first_name":"mohit","last_name":"prajapat","email":"mohit.prajapati@mmf.in","country_code":"+91","phone_no":"1111111111","status":"1"},{"id":10,"first_name":"priyanshu","last_name":"gupta","email":"priyanshu@mmfinfotech.in","country_code":"+91","phone_no":"1234567890","status":"1"}]
/// currentPage : 1
/// lastPage : 17
/// total : 163
/// perPage : 10

class UserlistModel {
  UserlistModel({
      bool? status, 
      String? message, 
      List<UserList>? userList, 
      num? currentPage, 
      num? lastPage, 
      num? total, 
      num? perPage,}){
    _status = status;
    _message = message;
    _userList = userList;
    _currentPage = currentPage;
    _lastPage = lastPage;
    _total = total;
    _perPage = perPage;
}

  UserlistModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['userList'] != null) {
      _userList = [];
      json['userList'].forEach((v) {
        _userList?.add(UserList.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _lastPage = json['lastPage'];
    _total = json['total'];
    _perPage = json['perPage'];
  }
  bool? _status;
  String? _message;
  List<UserList>? _userList;
  num? _currentPage;
  num? _lastPage;
  num? _total;
  num? _perPage;
UserlistModel copyWith({  bool? status,
  String? message,
  List<UserList>? userList,
  num? currentPage,
  num? lastPage,
  num? total,
  num? perPage,
}) => UserlistModel(  status: status ?? _status,
  message: message ?? _message,
  userList: userList ?? _userList,
  currentPage: currentPage ?? _currentPage,
  lastPage: lastPage ?? _lastPage,
  total: total ?? _total,
  perPage: perPage ?? _perPage,
);
  bool? get status => _status;
  String? get message => _message;
  List<UserList>? get userList => _userList;
  num? get currentPage => _currentPage;
  num? get lastPage => _lastPage;
  num? get total => _total;
  num? get perPage => _perPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_userList != null) {
      map['userList'] = _userList?.map((v) => v.toJson()).toList();
    }
    map['currentPage'] = _currentPage;
    map['lastPage'] = _lastPage;
    map['total'] = _total;
    map['perPage'] = _perPage;
    return map;
  }

}

/// id : 1
/// first_name : "Mohit"
/// last_name : "Prajapati"
/// email : "mohit@gmail.com"
/// country_code : "+91"
/// phone_no : "1326458790"
/// status : "1"

class UserList {
  UserList({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? countryCode, 
      String? phoneNo, 
      String? status,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _countryCode = countryCode;
    _phoneNo = phoneNo;
    _status = status;
}

  UserList.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _countryCode = json['country_code'];
    _phoneNo = json['phone_no'];
    _status = json['status'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _countryCode;
  String? _phoneNo;
  String? _status;
UserList copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? email,
  String? countryCode,
  String? phoneNo,
  String? status,
}) => UserList(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  countryCode: countryCode ?? _countryCode,
  phoneNo: phoneNo ?? _phoneNo,
  status: status ?? _status,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get phoneNo => _phoneNo;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['phone_no'] = _phoneNo;
    map['status'] = _status;
    return map;
  }

}