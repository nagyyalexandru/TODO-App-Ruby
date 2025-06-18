class TasksController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_todo_list
  before_action :set_task, only: [ :update, :destroy ]

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @task = @todo_list.tasks.build(task_params.merge(completed: false))

    respond_to do |format|
      if @task.save
        format.turbo_stream
        format.html { redirect_to root_path }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "task_form_#{@todo_list.id}",
            partial: "tasks/form",
            locals: { task: @task }
          )
        end
        format.html { render :new }
      end
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
