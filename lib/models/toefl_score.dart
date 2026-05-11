class ToeflScore {
  final int listening;
  final int structure;
  final int reading;
  final int total;
  final String status;

  const ToeflScore({
    required this.listening,
    required this.structure,
    required this.reading,
    required this.total,
    required this.status,
  });

  factory ToeflScore.initial() {
    return const ToeflScore(
      listening: 80,
      structure: 80,
      reading: 90,
      total: 250,
      status: 'LULUS',
    );
  }

  factory ToeflScore.fromJson(Map<String, dynamic> json) {
    return ToeflScore(
      listening: json['listening'] ?? 0,
      structure: json['structure'] ?? 0,
      reading: json['reading'] ?? 0,
      total: json['total'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listening': listening,
      'structure': structure,
      'reading': reading,
      'total': total,
      'status': status,
    };
  }
}
