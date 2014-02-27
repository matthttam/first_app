module SessionsHelper

  def sign_in(user, permanent_login = '0')
    remember_token = User.new_remember_token
    if(permanent_login == '1')
      flash[:success] = 'Successfully logged in!  To sign out you must click the signout button.'
      cookies.permanent[:remember_token] = remember_token
    else
      flash[:success] = 'Successfully logged in!'
      cookies[:remember_token] = { value: remember_token, expires: 1.hour.from_now }
    end
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    if(current_user)
      current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    end
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
