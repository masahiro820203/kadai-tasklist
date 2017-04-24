class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  # def index
  #   @users = User.all.page(params[:page])
  # end

  def show
    @user = User.find_by(id: session[:user_id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    counts @user
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
  
end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to root_path
    end
  end

