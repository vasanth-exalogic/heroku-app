class UserController < ApplicationController

  def new
    @user = User.find(session[:id])
  end

  def create
    @user = User.find(session[:id])
    if @user.update(user_params)
      redirect_to @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:fname,:lname,:datebirth,:datejoining,:age,:sal,:salpm,:contact,:bloodtype,:address,
    :city,:state,:country,:pincode,:gender,:ename,:relation,:econtact,:pskill,:sskill,:sskill2,:notice, :role)
  end

end
