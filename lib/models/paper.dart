class Paper {
  final String title;
  final String abstract;
  final String authors;
  final String year;
  final int citationCount;
  final String url;

  Paper({
    required this.title,
    required this.abstract,
    required this.authors,
    required this.year,
    required this.citationCount,
    required this.url,
  });

  // Factory constructor to create a Paper from a JSON map
  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      title: json['title'] ?? 'No Title',
      abstract: json['abstract'] ?? 'No Abstract',
      authors: (json['authors'] != null)
          ? (json['authors'] as List<dynamic>)
              .map((author) => author['name'])
              .join(', ')
          : 'No Authors',
      year: json['publicationYear']?.toString() ?? 'Unknown',
      citationCount: json['citationCount'] ?? 0,
      url: json['documentLink'] ?? '',
    );
  }

  // Method to convert a Paper object to a JSON map (optional)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'abstract': abstract,
      'authors': authors,
      'year': year,
      'citationCount': citationCount,
      'url': url,
    };
  }
}
