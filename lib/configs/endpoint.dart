class Endpoint {
  static const BASE_URL = 'https://cp-smart-building-dev.as.r.appspot.com';
  static const SIGN_IN = '/api/login';
  static const ROOM = '$BASE_URL/api/rooms';
  static const getAllUser = '$BASE_URL/api/users';
  static String getUserById(String id) => '$BASE_URL/api/users/$id';
  static const meeting = '$BASE_URL/api/meetings';
  static String updateMeeting(String id) => '$BASE_URL/api/meetings/$id';
  static String getNotification(int page) => '$BASE_URL/api/test/notifications?page=$page&limit=10';
  static String getRoomDetail(String roomId) => '$BASE_URL/api/rooms/$roomId';
  static const myMeeting = '$BASE_URL/api/meetings/my-meetings';
  static meetingDetail(String id) => '$BASE_URL/api/meetings/$id';
  static meetingRoom(
    String room,
    int startTime,
    int endTime,
  ) =>
      '$BASE_URL/api/meetings/room/$room?start_time=$startTime&end_time=$endTime';
  static const FORGOT_PASSWORD = '';
}
