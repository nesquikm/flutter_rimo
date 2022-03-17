abstract class ApiFilters {
  Map<String, String?> getFields();

  String getQuery() {
    var query = '';

    getFields().entries.forEach((element) {
      if (element.value != null && element.value!.isNotEmpty) {
        query += query.isEmpty ? '?' : '&';
        query += '${element.key}=${element.value}';
      }
    });

    return query;
  }
}
