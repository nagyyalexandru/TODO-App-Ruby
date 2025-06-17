class ListSharesController < ApplicationController
  before_action :set_todo_list

  def create
    @list_share = @todo_list.list_shares.new(list_share_params)
    
    if @list_share.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :new
    end
  end

  def destroy
    @list_share = @todo_list.list_shares.find(params[:id])
    @list_share.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def list_share_params
    params.require(:list_share).permit(:user_id, :permission_level)
  end
end