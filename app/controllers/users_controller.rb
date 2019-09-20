class UsersController < ApplicationController


  def index
    @users= User.all
  end

  def new
    @user = User.new
  end

    def create
      @user = User.new(user_params)
      if @user.save
        log_in(@user)
        permanent_user
        remember(@user)
        flash[:success] = "Welcome new user!"
        redirect_to @user
      else
        render 'new'
      end
    end

  def show
    @user = permanent_user
    puts @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
