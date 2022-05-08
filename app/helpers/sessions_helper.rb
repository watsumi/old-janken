module SessionsHelper
  def remember(user)
    session[:user_id] = user.id
    session[:user_token] = user.user_token
  end

  def current_user
    user = User.find_by(id: session[:user_id])
    @current_user ||= user if user.present? && user.authenticated?(session)
  end
end
