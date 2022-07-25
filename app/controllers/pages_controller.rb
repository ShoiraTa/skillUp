class PagesController < ApplicationController
  skip_before_action :authenticate_user!, :only=> [:index]
  def index
    # Withour scopes, for reference
    # @recent_courses = Course.all.limit(3).order(created_at: :desc)
    # @latest_good_reviews = Enrollment.reviewed.all.order(rating: :desc, created_at: :desc).limit(3)

    # @top_rated_courses = Course.order(avg_rating: :desc,  created_at: :desc).limit(3)
    # @popular_courses = Course.order(enrollments_count: :desc,  created_at: :desc).limit(3)
    # @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)

    # with scopes
    @recent_courses = Course.recent_courses.published.approved
    @latest_good_reviews = Enrollment.reviewed.latest_good_reviews
    @top_rated_courses = Course.top_rated_courses.published.approved
    @popular_courses = Course.popular_courses.published.approved
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def activity
    if current_user.has_role?(:admin)
      @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
    else
      redirect_to root_path, alert: "You are not authorised"
    end
  end


  def statistics
    if current_user.has_role?(:admin)
      @enrollments = Enrollment.all
      @users = User.all
      @courses = Course.all
    else
      redirect_to root_path, alert: "You are not authorised"
    end
  end
end
