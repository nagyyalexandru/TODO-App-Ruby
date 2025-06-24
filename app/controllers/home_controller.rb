class HomeController < ApplicationController
  def index
    if current_user
      @todo_lists = current_user.accessible_todo_lists
      @todo_list = TodoList.new
    end
  end
end