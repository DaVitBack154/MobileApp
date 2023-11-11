class DateFormatter {
  static String formatDate(String inputDate) {
    final year = inputDate.substring(0, 4);
    final month = inputDate.substring(4, 6);
    final day = inputDate.substring(6, 8);
    final monthNames = [
      '',
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม',
    ];

    final formattedDate = '$day ${monthNames[int.parse(month)]} $year';

    return formattedDate;
  }
}
