class Book {
  final int? id;
  final String title;
  final String author;
  final String? coverImagePath;
  final String status; // read, reading, to_read
  final int progressPercent; // 0-100
  final bool isFavorite;

  const Book({
    this.id,
    required this.title,
    required this.author,
    this.coverImagePath,
    this.status = 'to_read',
    this.progressPercent = 0,
    this.isFavorite = false,
  });

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? coverImagePath,
    String? status,
    int? progressPercent,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      status: status ?? this.status,
      progressPercent: progressPercent ?? this.progressPercent,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int?,
      title: map['title'] as String,
      author: map['author'] as String,
      coverImagePath: map['coverImagePath'] as String?,
      status: map['status'] as String? ?? 'to_read',
      progressPercent: map['progressPercent'] as int? ?? 0,
      isFavorite: (map['isFavorite'] as int? ?? 0) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'coverImagePath': coverImagePath,
      'status': status,
      'progressPercent': progressPercent,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}


