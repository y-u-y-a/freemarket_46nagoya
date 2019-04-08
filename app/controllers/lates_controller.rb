class LatesController < ApplicationController
  before_action :set_user
  before_action :set_search
  before_action :set_category

  def index
    @lates = Late.where(late_user: @user.id).order(id: "DESC")
  end

  def great
    @lates = Late.where(late_user: @user.id).where(late: 1).order(id: "DESC")
  end

  def good
    @lates = Late.where(late_user: @user.id).where(late: 2).order(id: "DESC")
  end

  def poor
    @lates = Late.where(late_user: @user.id).where(late: 3).order(id: "DESC")
  end

  private

  def set_user
    @user = User.find(current_user)
  end

end
