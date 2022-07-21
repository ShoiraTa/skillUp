class ApplicationController < ActionController::Base
  include PublicActivity::StoreController 
  include Pundit::Authorization 
  include Pagy::Backend
  
  before_action :authenticate_user!
  before_action :set_global_variables, if: :user_signed_in?
  after_action :user_activity


  # Ransack
  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
  end

  # Check if user online
  def user_activity
    current_user.try :touch
  end

  # Pundit setup Rescuing a denied Authorization in Rails
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
    # Pundit setup Rescuing a denied Authorization in Rails
end
