class UsersController < ApplicationController
  before_action :find_user, except: [:index, :create, :new]
  before_action :is_admin?, except: [:show]
  before_action :is_user?, only: [:show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @error3
    @user = User.new(user_params)
    if @user.save && is_elder?(@user.datebirth)
      redirect_to @user
    else
      @error3="Please enter proper Email-id and Password or Check if User is above 18 years old"
      render 'new'
    end
  end

  def edit
  end

  def update
    @error4

    if @user.update(user_params)
      redirect_to @user
    else
      @error4="Please enter proper Email-id and Password"
      render 'edit'
    end
  end

  def show
    if @user.datebirth!=nil
      @user.age=find_age(@user.datebirth)
    end
    if @user.sal!=nil
      @user.salpm=find_sal(@user.sal)
    end
    if @user.bloodtype == 'Blood Type'
      @user.bloodtype=nil
    end
    if @user.gender == 'Gender'
      @user.gender=nil
    end
    if @user.country == 'Country'
      @user.country=nil
    end
    if @user.relation == 'Relation'
      @user.relation=nil
    end
    if @user.state == 'State'
      @user.state=nil
    end
  end

  def destroy
    @user.destroy
    redirect_to '/users'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:fname,:lname,:datebirth,:datejoining,:age,:sal,:salpm,:contact,:bloodtype,
    :address,:city,:state,:country,:pincode,:gender,:ename,:relation,:econtact,:pskill,:sskill,:sskill2,
    :notice,:email,:password,:password_confirmation)
  end

  def is_admin?
    if session[:user_type]!='admin'
      redirect_to root_path
    end
  end

  def is_user?
    unless session[:user_id]==@user.id || session[:user_type]=='admin'
      redirect_to root_path
    end
  end

  def find_age(datebirth)
    (Date.today-(datebirth.to_date))/365.to_i
  end

  def find_sal(sal)
    sal/12
  end

  def is_elder?(date)
    find_age(date)>=18
  end
end
