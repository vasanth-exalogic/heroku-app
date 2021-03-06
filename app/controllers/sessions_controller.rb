class SessionsController < ApplicationController
  def index
    session[:user_type]=nil
  end

  def create
    @error
    user = User.find_by_email(userparams[:email])
    if user && user.authenticate(userparams[:password])
      if user.role=='admin'
        session[:user_type]='admin'
        redirect_to '/users'
      else
        session[:user_type]='user'
        session[:user_id]=user.id
        redirect_to user
      end
    else
      @error="Invalid email-id or password"
      render 'index'
    end
  end

  def destroy
    session[:user_type]=nil
    redirect_to root_path
  end

  private

  def userparams
    params.require(:user).permit(:email,:password, :role)
  end
end
