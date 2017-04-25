class UsersController < ApplicationController

  def show
    @user = User.new
  end

  def create
    user = User.new(user_params)
# not working below
    # emailMatch = User.find_by(email: params[:email])

    if user.save
      session[:user_id] = user.id
      redirect_to :root, notice: 'New user created!'
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
