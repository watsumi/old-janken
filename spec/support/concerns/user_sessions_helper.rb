module UserSessionsHelper
  def login_as(user)
    get "/login_as/#{user.id}?game_id=#{user.game_id}"
    expect(logged_in?).to be_truthy
  end

  def logged_in?
    !!current_user
  end

  def current_user
    user = User.find_by(id: session[:user_id])
    @current_user ||= user if user.present? && user.authenticated?(session)
  end
end
