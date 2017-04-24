class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy]
  
  def show
    set_task
  end
   
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render 'toppages/index'
    end
  end
  
  def edit
    set_task
  end
  
  def update
    set_task
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に修正されました'
      redirect_to root_path
    else
      flash.now[:danger] ='タスクは正常に修正されませんでした。'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
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
