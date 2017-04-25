class SessionsController < ApplicationController

  def show
  end

	def create
	# searching db to see if session email matches any
  # (email: params[:email])
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      redirect_to :sessions
    end
	end

	def destroy
    session[:user_id] = nil
    redirect_to :root
	end

end
