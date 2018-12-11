module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  # 点击log_out,安全退出.只关闭浏览器时会保存cookie,安全退出后就没有了
  def log_out
    forget_user(current_user)
    session.delete(:user_id)
  end

  # Returns the user corresponding to the remember token cookie.
  #获取当前登录用户，如未登录，则为nil.@current_user这个实例变量是为了避免每次调用current_user方法都去查询一遍数据库的情况。
  def current_user
    #判断seession
    if session[:user_id]
      @current_user||= User.find_by(id: session[:user_id])
    #判断cookies
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      #如果cookies中保存了，再用authenticated?这个方法判断cookies[:remeber_token]或者数据库中的remeber_digest是否一致。
      if user && user.user_authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def remember_user(user)
    user.user_remember
    # Because it places the id as plain text, this method exposes the form of the application’s cookies
    # and makes it easier for an attacker to compromise user accounts. To avoid this problem,
    # we’ll use a signed cookie, which securely encrypts the cookie before placing it on the browser:
    cookies.signed[:user_id] = {value: user.id, expires: 5.minutes.from_now.utc}
    cookies[:remember_token] = {value: user.remember_token, expires: 5.minutes.from_now.utc}
  end

  def forget_user(user)
    user.user_forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user?(user)
    user == current_user
  end


end
