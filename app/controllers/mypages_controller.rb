class MypagesController < ApplicationController

  def index
  end

  def update
  end

  private
  def update_params
    params.require(:user).permit(:nickname,:profile_text,:avatar)
  end
end
