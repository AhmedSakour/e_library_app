class ApiConfig {
  static const String baseUrl = 'http://192.168.1.34:5000/api';

  // Auth
  static const String loginUrl = '/auth/login';
  static const String signupUrl = '/auth/signup';

  // Admin
  static const String addBookUrl = '/admin/books';
  static const String addAuthorUrl = '/admin/authors';
  static const String addPublisherUrl = '/admin/publishers';

  // General
  static const String getAllBooks = '/general/books';
  static const String searchBooks = '/general/search/books';
  static const String searchAuthors = '/general/search/authors';
  static const String searchPublishers = '/general/search/publishers';
  static const String getAllAuthors = '/general/authors';
  static const String getAllPublishers = '/general/publishers';
}
