class ChatDateFormatter {
  static String formatDate(String inputDate) {
    try {
      // แยกวัน เดือน ปี จากรูปแบบ yyyy-MM-dd
      final parts = inputDate.split('-');
      if (parts.length != 3) {
        throw FormatException("Invalid date format");
      }

      final year = parts[0];
      final month = parts[1];
      final day = parts[2];

      final monthNames = [
        '',
        'ม.ค.',
        'ก.พ.',
        'มี.ค.',
        'เม.ย.',
        'พ.ค.',
        'มิ.ย',
        'ก.ค.',
        'ส.ค.',
        'ก.ย.',
        'ต.ค.',
        'พ.ย.',
        'ธ.ค.',
      ];

      // เปลี่ยนเป็นปี พ.ศ. และแสดงเฉพาะสองหลักสุดท้าย
      final shortYear = (int.parse(year) + 543).toString().substring(2);

      final formattedDate = '$day ${monthNames[int.parse(month)]} $shortYear';

      return formattedDate;
    } catch (e) {
      return "Invalid date";
    }
  }
}
