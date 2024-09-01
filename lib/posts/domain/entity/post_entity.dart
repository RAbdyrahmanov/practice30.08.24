class PostEntity {
  final String title;
  final String description;
  final String author;

  PostEntity({required this.title, required this.description, required this.author});
  PostEntity.emty()
      : title = '',
        description = '',
        author = '';
}