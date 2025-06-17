class TasksController < ApplicationController
  before_action :set_todo_list
  before_action :set_task, only: [:update, :destroy]

  def create
    @task = @todo_list.tasks.new(task_params)
    @task.position = @todo_list.tasks.maximum(:position).to_i + 1

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_todo_list
    @todo_list = current_user.accessible_todo_lists.find(params[:todo_list_id])
  end

  def set_task
    @task = @todo_list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed, :notes)
  end

  def update_position
    task.insert_at(params[:position].to_i)
    head :ok
  end
end