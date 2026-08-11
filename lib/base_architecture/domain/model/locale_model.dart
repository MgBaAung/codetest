import '../../core/master_object.dart';

// ignore: must_be_immutable
class LocaleModel extends MasterObject<LocaleModel> {
  static final LocaleModel _instance = LocaleModel._internal();
  factory LocaleModel() => _instance;
  LocaleModel._internal() : super(id: 0);

  String? languageCode;
  LocaleModel.init({this.languageCode}) : super(id: 0);

  @override
  LocaleModel fromMap(dynamicData) {
    throw UnimplementedError();
  }

  @override
  List<LocaleModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(LocaleModel? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<LocaleModel> objectList) {
    throw UnimplementedError();
  }
}
