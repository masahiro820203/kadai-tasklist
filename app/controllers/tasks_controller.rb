class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasks = Task.all
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render 'toppages/index'
    end
  end
  
  def edit
  end
  
  # def update
    
  #   if @task.update(task_params)
  #     flash[:success] = 'タスクは正常に修正されました'
  #     redirect_to @task
  #   else
  #     flash.now[:danger] ='タスクは正常に修正されませんでした。'
  #     render :edit
  #   end
  # end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_task
    @task =Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to root_path
    end
  end
end
