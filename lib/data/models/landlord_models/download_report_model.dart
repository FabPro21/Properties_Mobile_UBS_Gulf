// ignore_for_file: unnecessary_null_comparison

class DownloadReportModel {
  FilePath? filePath;
  String? message;

  DownloadReportModel({this.filePath, this.message});

  DownloadReportModel.fromJson(Map<String?, dynamic> json) {
    filePath = json['filePath'] != null
        ? FilePath.fromJson(json['filePath'])
        : null;
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    if (filePath != null) {
      data['filePath'] = filePath!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class FilePath {
  String? result;
  int? id;
  dynamic exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;
  dynamic asyncState;
  bool? isFaulted;

  FilePath(
      {this.result,
      this.id,
      this.exception,
      this.status,
      this.isCanceled,
      this.isCompleted,
      this.isCompletedSuccessfully,
      this.creationOptions,
      this.asyncState,
      this.isFaulted});

  FilePath.fromJson(Map<String?, dynamic> json) {
    result = json['result'];
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['result'] = result;
    data['id'] = id;
    data['exception'] = exception;
    data['status'] = status;
    data['isCanceled'] = isCanceled;
    data['isCompleted'] = isCompleted;
    data['isCompletedSuccessfully'] = isCompletedSuccessfully;
    data['creationOptions'] = creationOptions;
    data['asyncState'] = asyncState;
    data['isFaulted'] = isFaulted;
    return data;
  }
}
