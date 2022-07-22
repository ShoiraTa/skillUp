class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  def index
    # @users = User.all.order(created_at: :desc)
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @pagy, @users = pagy(@q.result(distinct: true))

    authorize @users

  end

  def edit
  end
  def show
  end
  def update
    authorize @user
    if @user.update(user_params)
      redirect_to users_path, notice: "User #{@user.email} was successfullu updated"
    else
      render :edit
    end
    
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
  def user_params
    params.require(:user).permit({role_ids: []})
  end
end
