class Filter {
  static List<String> categoryData = [
    'Others',
    'Computer Engineering',
    'Gaming',
    'Cafeteria Prices'
  ];
  static List<String> selectedCategoryData = [];

  static remove(String data) {}
  static select(String data) {
    if (selectedCategoryData.isEmpty) {
      selectedCategoryData.add(data);
      return true;
    } else if (selectedCategoryData.contains(data)) {
      selectedCategoryData.remove(data);
      return false;
    } else if (!selectedCategoryData.contains(data)) {
      selectedCategoryData.clear();
      selectedCategoryData.add(data);
      return true;
    }
  }
}
