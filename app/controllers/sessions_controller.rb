class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      @errors = ['Invalid username/password combination.']
      render 'new'
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end

end
