class Song {
  final int id;
  final String url;
  final String name;
  final String artist;

  Song({
    required this.id,
    required this.url,
    required this.name,
    required this.artist
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json['id'] as int,
        url: json['url'] as String,
        name: json['name'] as String,
        artist: json['artist'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'artist': artist
    };
  }
}