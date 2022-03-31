class Album {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Album(this.albumId, this.id, this.title, this.thumbnailUrl, this.url);

  @override
  String toString() {
    return "{id: $id, albumId: $albumId, title: $title, url: $url }";
  }
}
