module SessionsHelper
  def remember(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:user_token] = user.user_token
  end

  def current_user
    user = User.find_by(id: cookies.signed[:user_id])
    @current_user ||= user if user.present? && user.authenticated?(cookies[:user_token])
  end
end
