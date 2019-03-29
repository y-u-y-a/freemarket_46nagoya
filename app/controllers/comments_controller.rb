class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(params[:item_id])
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to item_path(params[:item_id])
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,item_id: params[:item_id], no_comment: 0)

  end
end
