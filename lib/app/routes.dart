abstract final class Routes {
  static const calendar = '/calendar';
  static const reports = '/reports';
  static const shifts = '/shifts';
  static const settings = '/settings';
  static const newTemplate = '/template/new';
  static const templateIdParam = 'id';
  static const template = '/template/:$templateIdParam';
  static const logs = '/logs';

  static String templateById(String id) {
    return '/template/$id';
  }
}
