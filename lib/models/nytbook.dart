class NYTBook {
  String title;
  String author;
  // Date "created_date"
  NYTBook(String title, String author) {
    this.title = title;
    this.author = author;
  }

  NYTBook.fromJson(Map json)
      : title = json['title'],
        author = json['author'];

  Map toJson() {
    return {'title': title, 'author': author};
  }
}
