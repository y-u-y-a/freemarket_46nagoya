class ItemsController < ApplicationController
  def index
  end
 
  def new
  end

  def create
    Item.create()
  end

  def buy
  end
end
