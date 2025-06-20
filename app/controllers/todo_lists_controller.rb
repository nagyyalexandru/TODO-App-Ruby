class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [ :edit, :update, :destroy ]

  def index
    @todo_lists = current_user.accessible_todo_lists
    @todo_list = TodoList.new
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    @todo_lists = current_user.accessible_todo_lists # Needed to re-render index if needed

    if @todo_list.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_todo_list",
            partial: "todo_lists/form",
            locals: { todo_list: @todo_list }
          )
        end
        format.html { redirect_to root_path, alert: "Title can't be blank" }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "edit_todo_list_#{@todo_list.id}",
          partial: "todo_lists/form",
          locals: { todo_list: @todo_list }
        )
      end
      format.html do
        render partial: "todo_lists/form", locals: { todo_list: @todo_list }, layout: false
      end
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "edit_todo_list_#{@todo_list.id}",
            partial: "todo_lists/todo_list",
            locals: { todo_list: @todo_list }
          )
        end
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "edit_todo_list_#{@todo_list.id}",
            partial: "todo_lists/todo_list",
            locals: { todo_list: @todo_list, editing: true }
          )
        end
        format.html { render :edit }
      end
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
