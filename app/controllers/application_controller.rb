class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include PublicActivity::StoreController #save current_user using gem public_activity
  
  before_action :set_global_variables, if: :user_signed_in?
  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
  end

  # Pundit setup Rescuing a denied Authorization in Rails
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
