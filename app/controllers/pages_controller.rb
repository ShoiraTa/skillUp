class PagesController < ApplicationController
  skip_before_action :authenticate_user!, :only=> [:index]
  def index
    @popular_courses = Course.limit(3)
    @top_rated_courses = Course.where('title ILIKE ?', '%design%')
    @recent_courses = Course.all.limit(3).order(created_at: :desc)
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
