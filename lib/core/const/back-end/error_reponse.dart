class LoginErrorMessage {
  static const String wrongCredentials = "Sai tên đăng nhập hoặc mật khẩu.";
  static const String accountLocked =
      "Tài khoản đã bị khóa. Vui lòng liên hệ với quản trị viên.";
  static const String connectionError =
      "Không thể kết nối đến máy chủ. Vui lòng kiểm tra kết nối internet và thử lại sau.";
  static const String systemError =
      "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.";
}

class DiaLogMessage {
  static const String title = "Thông báo";
  static const String confirm = "Xác nhận";
  static const String cancel = "Hủy";
  static const String ok = "OK";
  static const String close = "Đóng";
}

class LoginSuccessMessage {
  static String loginSuccess(String username) =>
      "Thành công, chào mừng $username trở lại!";
  static const String passwordChanged = "Mật khẩu đã được thay đổi thành công.";
  static const String logoutSuccess = "Đã đăng xuất thành công.";
}

class SearchErrorMessage {
  static const String noResultsFound =
      "Không tìm thấy kết quả nào phù hợp với yêu cầu của bạn.";
}

class SearchSuccessMessage {
  static String resultsFound(int count) =>
      "Đã tìm thấy $count kết quả phù hợp với yêu cầu của bạn.";
}

class OperationErrorMessage {
  static const String systemError =
      "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.";
  static const String createError =
      "Không thể thêm mới mục này. Vui lòng thử lại sau hoặc liên hệ với quản trị viên.";
  static const String accessDenied =
      "Bạn không có quyền truy cập vào tài nguyên này.";
  static const String deleteError =
      "Không thể xóa mục này. Vui lòng thử lại sau hoặc liên hệ với quản trị viên.";
}

class OperationSuccessMessage {
  static String changePasswordSuccess(String username) =>
      "Mật khẩu của $username đã được thay đổi thành công.";
  static String signUpSuccess(String username) =>
      "Đã tạo tài khoản $username thành công! Đăng nhập để bắt đầu sử dụng dịch vụ của Lumos.";
  static String createSuccess(String itemName) =>
      "Đã thêm mới $itemName thành công.";
  static String updateSuccess(String itemName) =>
      "Đã cập nhật thông tin $itemName thành công.";
  static String deleteSuccess(String itemName) =>
      "Đã xóa $itemName thành công.";
}

class BookingErrorMessage {
  static const String invalidTimeSlot =
      "Thời gian bạn chọn không khả dụng. Vui lòng chọn thời gian khác.";
  static const String bookingConflict =
      "Đã có lịch đặt khác cho thời gian bạn chọn. Vui lòng chọn thời gian khác.";
  static const String emptyList = "Danh sách trống, vui lòng thử lại sau.";
  static const String bookingDateTimeAddrEmpty =
      "Vui lòng cung cấp đầy đủ thông tin về ngày, khung giờ và địa chỉ để đặt dịch vụ.";
}

class BookingSuccessMessage {
  static const String bookingSuccess =
      "Đặt dịch vụ thành công. Xin cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!";
}

class OnDevelopmentMessage {
  static const String fearureOnDevelopmentTitle = "Tính năng đang phát triển";
  static const String featureOnDevelopment =
      "Tính năng này đang được phát triển. Vui lòng quay lại sau.";
}

class OnInvalidInputMessage {
  static const String emptyInput = "Vui lòng nhập dữ liệu trước khi thực hiện";
  static const String invalidInputTitle = "Dữ liệu không hợp lệ";
  static const String invalidInput =
      "Dữ liệu bạn nhập không hợp lệ. Vui lòng kiểm tra lại.";
  static const String invalidEmail =
      "Email không hợp lệ. Vui lòng kiểm tra lại.";
  static const String invalidPassword =
      "Mật khẩu không hợp lệ. Vui lòng kiểm tra lại.";
  static const String passwordGuide =
      "Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.";
  static const String invalidPhoneNumber =
      "Số điện thoại không hợp lệ. Vui lòng kiểm tra lại.";
  static const String phoneGuide =
      "Số điện thoại phải bắt đầu bằng số 0, và có 10 chữ số.";
  static const String invalidName = "Tên không hợp lệ. Vui lòng kiểm tra lại.";
  static const String nameGuide =
      "Tên không được chứa ký tự đặc biệt và phải viết hoa chữ cái đầu của mỗi từ.";
  static const String alreadyExist =
      "Dữ liệu đã tồn tại. Vui lòng kiểm tra lại.";
  static const String serviceExisted =
      "Dịch vụ đã tồn tại. Vui lòng kiểm tra lại.";

  static const String signUpGuide =
      "- Tên: Tên không được chứa ký tự đặc biệt và phải viết hoa chữ cái đầu của mỗi từ.\n"
      "- Email: email hợp lệ là email có chứa @ và .com, .vn, .org, .edu,...\n"
      "- Số điện thoại: Số điện thoại phải bắt đầu bằng số 0, và có 10 chữ số.\n"
      "- Mật khẩu: Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.";
}

class OnSignOutMessage {
  static const String signOutTitle = "Đăng xuất";
  static const String signOutMessage = "Bạn có chắc chắn muốn đăng xuất?";
  static const String signOutConfirm = "Đăng xuất";
  static const String signOutCancel = "Hủy";
}
