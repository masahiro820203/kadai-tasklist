class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :set_user, only: [:show]
  before_action :correct_user, only: [:show]
  # def index
  #   @users = User.all.page(params[:page])
  # end

  def show
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーを登録しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end
  

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
  end
end