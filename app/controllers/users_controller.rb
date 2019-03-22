class UsersController < ApplicationController
  before_action :set_category, only: [ :index, :show, :logout, :payment_method, :card_registration, :indentification]

  def index
  end

  def show
  end



  def to_signup
  end

  def logout
  end

  def payment_method
  end

  def card_registration
  end

  def indentification
  end

  private

end
