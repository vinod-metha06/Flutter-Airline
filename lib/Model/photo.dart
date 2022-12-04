class Photos {
  var albumId;
  var id;
  var title;
  var url;

  Photos({
     this.albumId,
     this.id,
     this.title,
     this.url,
  });
   factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }

}
