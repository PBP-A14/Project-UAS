import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
    String model;
    int pk;
    Fields fields;

    UserProfile({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    int progressLiterasi;
    int targetBuku;
    int progress;
    List<dynamic> readingList;
    List<dynamic> historyBacaan;

    Fields({
        required this.user,
        required this.progressLiterasi,
        required this.targetBuku,
        required this.progress,
        required this.readingList,
        required this.historyBacaan,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        progressLiterasi: json["progress_literasi"],
        targetBuku: json["target_buku"],
        progress: json["progress"],
        readingList: List<dynamic>.from(json["reading_list"].map((x) => x)),
        historyBacaan: List<dynamic>.from(json["history_bacaan"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "progress_literasi": progressLiterasi,
        "target_buku": targetBuku,
        "progress": progress,
        "reading_list": List<dynamic>.from(readingList.map((x) => x)),
        "history_bacaan": List<dynamic>.from(historyBacaan.map((x) => x)),
    };
}
