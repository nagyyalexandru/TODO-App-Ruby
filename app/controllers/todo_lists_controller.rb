class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [ :update, :destroy ]

  def index
    @todo_lists = current_user.accessible_todo_lists
    @todo_list = TodoList.new
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)

    if @todo_list.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :new
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_todo_list
    @todo_list = current_user.accessible_todo_lists.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
