class LikesController < ApplicationController

  before_action :set_item,     only: [:create, :destroy]
  before_action :set_user,     only: :index
  before_action :set_search,   only: :index
  before_action :set_category, only: :index

  def index
    @likes = Like.where(user_id: @user.id)
    @items = []
    @likes.each do |like|
      @items << like.item
    end
  end

  def create
    @like = Like.create(user_id: current_user.id, item_id: params[:item_id])
    @likes = Like.where(item_id: params[:item_id])
    @item.reload
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    like.destroy
    @likes = Like.where(item_id: params[:item_id])
    @item.reload
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_user
    @user = User.find(current_user)
  end
end
