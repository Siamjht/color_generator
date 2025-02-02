
class GeminiResponseModel {
  List<Candidates>? candidates;

  GeminiResponseModel({this.candidates});

  GeminiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(Candidates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.candidates != null) {
      data['candidates'] = this.candidates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Candidates {
  Content? content;
  String? finishReason;
  int? index;
  List<SafetyRatings>? safetyRatings;

  Candidates({this.content, this.finishReason, this.index, this.safetyRatings});

  Candidates.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    finishReason = json['finishReason'];
    index = json['index'];
    if (json['safetyRatings'] != null) {
      safetyRatings = <SafetyRatings>[];
      json['safetyRatings'].forEach((v) {
        safetyRatings!.add(new SafetyRatings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['finishReason'] = this.finishReason;
    data['index'] = this.index;
    if (this.safetyRatings != null) {
      data['safetyRatings'] =
          this.safetyRatings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  List<Parts>? parts;
  String? role;

  Content({this.parts, this.role});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(new Parts.fromJson(v));
      });
    }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    data['role'] = this.role;
    return data;
  }
}

class Parts {
  String? text;

  Parts({this.text});

  Parts.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class SafetyRatings {
  String? category;
  String? probability;

  SafetyRatings({this.category, this.probability});

  SafetyRatings.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['probability'] = this.probability;
    return data;
  }
}
