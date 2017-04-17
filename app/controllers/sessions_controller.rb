class SessionsController < ApplicationController

	def create
	# searching db to see if session email matches any
    @session = User.find_by(email: params[:email])

    if @session && session.authenticate(params[:password])
      session[:user_id] = @session.id
      redirect_to :root, notice: 'Welcome Back!'
    else
      redirect_to :sessions
    end
	end

	def destroy
    session[:user_id] = nil
    redirect_to :index
	end

end
