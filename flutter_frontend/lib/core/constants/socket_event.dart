class SocketEvent {
  static String sendAddFriendRequest = 'send-friend-request';
  static String receiveAddFriendRequest = 'receive-friend-request';
  static String acceptAddFriendRequest = 'accept-friend-request';
  static String notifyAcceptAddFriendRequest = 'notify-accept-friend';

  // ---- ALREADY FRIEND AND NOW UNFRIEND ---- //
  static String sendCancelFriend = 'send-cancel-friend';
  static String receiveCancelFriend = 'receive-cancel-friend';
  //

  // ---- REFUSE ADD FRIEND REQUEST ---- //
  static String cancelFriendRequest = 'cancel-friend-request';
  static String removeFriendRequest = 'remove-friend-request';
  //

  static String sendConversationMessage = 'send-conver-message';
  static String receiveConversationMessage = 'receive-conver-message';

  static String sendRoomMessage = 'send-room-message';
  static String receiveRoomMessage = 'receive-room-message';

  static String sendCreateRoom = 'send-create-room';
  static String receiveCreateRoom = 'receive-create-room';

  static String sendJoinRoom = 'send-join-room';
  static String receiveJoinRoom = 'receive-join-room';

  static String sendRemoveConversationMessage = 'send-remove-conver-message';
  static String receiveRemoveConversationMessage = 'receive-remove-conver-message';

  static String sendRemoveRoomMessage = 'send-remove-room-message';
  static String receiveRemoveRoomMessage = 'receive-remove-room-message';
}