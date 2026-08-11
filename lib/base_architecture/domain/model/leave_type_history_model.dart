import '../../core/master_object.dart';

// ignore: must_be_immutable
class LeaveTypeHistoryModel extends MasterObject<LeaveTypeHistoryModel> {
  int? statusCode;
  int? messageCode;
  String? message;
  Data? data;

  LeaveTypeHistoryModel({
    this.statusCode,
    this.messageCode,
    this.message,
    this.data,
  }) : super(id: 0);

  @override
  LeaveTypeHistoryModel fromMap(dynamicData) {
    statusCode = dynamicData['statusCode'];
    messageCode = dynamicData['messageCode'];
    message = dynamicData['message'];
    data = dynamicData['data'] != null
        ? Data().fromMap(dynamicData['data'])
        : null;
    return this;
  }

  @override
  List<LeaveTypeHistoryModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(LeaveTypeHistoryModel? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(
    List<LeaveTypeHistoryModel> objectList,
  ) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Data extends MasterObject<Data> {
  List<Summary>? summary;
  List<History>? history;

  Data({this.summary, this.history}) : super(id: 0);

  @override
  Data fromMap(dynamicData) {
    summary = [];
    history = [];
    if (dynamicData['summary'] != null) {
      dynamicData['summary'].forEach((v) {
        summary!.add(Summary().fromMap(v));
      });
    }
    if (dynamicData['history'] != null) {
      dynamicData['history'].forEach((v) {
        history!.add(History().fromMap(v));
      });
    }
    return this;
  }

  @override
  List<Data> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Data? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Data> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Summary extends MasterObject<Summary> {
  num? leaveTypeId;
  String? leaveType;
  num? entitlement;
  num? balance;
  num? taken;

  Summary({
    this.leaveTypeId,
    this.leaveType,
    this.entitlement,
    this.balance,
    this.taken,
  }) : super(id: 0);

  @override
  Summary fromMap(dynamicData) {
    leaveTypeId = dynamicData['leaveTypeId'];
    leaveType = dynamicData['leaveType'];
    entitlement = dynamicData['entitlement'];
    balance = dynamicData['balance'];
    taken = dynamicData['taken'];
    return this;
  }

  @override
  List<Summary> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Summary? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Summary> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class History extends MasterObject<History> {
  String? leaveType;
  String? startdate;
  String? enddate;
  String? status;
  num? duration;

  History({
    this.leaveType,
    this.startdate,
    this.enddate,
    this.status,
    this.duration,
  }) : super(id: 0);

  @override
  History fromMap(dynamicData) {
    leaveType = dynamicData['leaveType'];
    startdate = dynamicData['startdate'];
    enddate = dynamicData['enddate'];
    status = dynamicData['status'];
    duration = dynamicData['duration'];
    return this;
  }

  @override
  List<History> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(History? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<History> objectList) {
    throw UnimplementedError();
  }
}
