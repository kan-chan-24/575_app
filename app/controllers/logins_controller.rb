class LoginsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/", notice: 'ログインしました'
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render 'new', status: :unprocessable_entity
    end
  end
end
