class LogoutsController < ApplicationController
  def show
    session.delete(:user_id)
    redirect_to "/", notice: 'ログアウトしました'
  end
end
