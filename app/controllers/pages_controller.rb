class PagesController < ApplicationController
  skip_before_action :authenticate_user!, :only=> [:index]
  def index
    @recent_courses = Course.all.limit(3).order(created_at: :desc)
    @latest_good_reviews = Enrollment.reviewed.all.order(rating: :desc, created_at: :desc).limit(3)

    @top_rated_courses = Course.order(avg_rating: :desc,  created_at: :desc).limit(3)
    @popular_courses = Course.order(enrollments_count: :desc,  created_at: :desc).limit(3)
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
