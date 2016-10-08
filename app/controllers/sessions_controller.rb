class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    #session[:session_token]
    #username, password - find_by_credentials
    @user = User.find_by_credentials(params[:user][:username],
    params[:user][:password])
    if @user.valid?
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end

  private
  # def user_params
  #   params.require(:user).permit(:username, :password)
  # end

end
