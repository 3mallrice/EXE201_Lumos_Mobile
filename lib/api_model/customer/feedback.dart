class FeedbackModel {
  String reason;
  Feedback? feedback;

  FeedbackModel({required this.reason, this.feedback});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        reason: json["reason"],
        feedback: Feedback.fromJson(json["feedback"]),
      );
}

class Feedback {
  int rating;
  String? feedbackPartner;
  String? feedbackLumos;
  String? feedbackImage;

  Feedback(
      {required this.rating,
      this.feedbackPartner,
      this.feedbackLumos,
      this.feedbackImage});

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
      rating: json["rating"],
      feedbackPartner: json["feedbackPartner"],
      feedbackLumos: json["feedbackLumos"],
      feedbackImage: json["feedbackImage"]);
}
