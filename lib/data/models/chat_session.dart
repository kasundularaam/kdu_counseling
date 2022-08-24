import 'dart:convert';

class ChatSession {
  final int id;
  final int isAnonymous;
  final String studentName;
  final String counsellorName;
  final String problemType;
  final String serviceMethod;
  final String remarks;
  ChatSession({
    required this.id,
    required this.isAnonymous,
    required this.studentName,
    required this.counsellorName,
    required this.problemType,
    required this.serviceMethod,
    required this.remarks,
  });

  ChatSession copyWith({
    int? id,
    int? isAnonymous,
    String? studentName,
    String? counsellorName,
    String? problemType,
    String? serviceMethod,
    String? remarks,
  }) {
    return ChatSession(
      id: id ?? this.id,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      studentName: studentName ?? this.studentName,
      counsellorName: counsellorName ?? this.counsellorName,
      problemType: problemType ?? this.problemType,
      serviceMethod: serviceMethod ?? this.serviceMethod,
      remarks: remarks ?? this.remarks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'is_anonnimus': isAnonymous,
      'student_name': studentName,
      'counsellor_name': counsellorName,
      'problem_type': problemType,
      'service_method': serviceMethod,
      'remarks': remarks,
    };
  }

  factory ChatSession.fromMap(Map<String, dynamic> map) {
    return ChatSession(
      id: map['id'] ?? -1,
      isAnonymous: map['is_anonnimus'] ?? 1,
      studentName: map['student_name'] ?? "",
      counsellorName: map['counsellor_name'] ?? "",
      problemType: map['problem_type'] ?? "",
      serviceMethod: map['service_method'] ?? "",
      remarks: map['remarks'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatSession.fromJson(String source) =>
      ChatSession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatSessions(id: $id, is_anonymous: $isAnonymous, student_name: $studentName, counsellor_name: $counsellorName, problem_type: $problemType, service_method: $serviceMethod, remarks: $remarks)';
  }

  @override
  bool operator ==(covariant ChatSession other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isAnonymous == isAnonymous &&
        other.studentName == studentName &&
        other.counsellorName == counsellorName &&
        other.problemType == problemType &&
        other.serviceMethod == serviceMethod &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isAnonymous.hashCode ^
        studentName.hashCode ^
        counsellorName.hashCode ^
        problemType.hashCode ^
        serviceMethod.hashCode ^
        remarks.hashCode;
  }
}
