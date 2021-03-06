class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, :only=> [:show]
  before_action :set_course, only: %i[ show edit update destroy approve unapprove analytics ]
  def index
    #if params[:title]
    #  @courses = Course.where('title ILIKE ?', "%#{params[:title]}%") #case-insensitive
    #else
    #  #@courses = Course.all
    #  
    #  #@q = Course.ransack(params[:q])
    #  #@courses = @q.result.includes(:user)
    #end
      @ransack_path= courses_path
      @ransack_courses = Course.published.approved.ransack(params[:courses_search], search_key: :courses_search)
      @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
  end

  def show
    @lessons = @course.lessons.rank(:row_order).all
    authorize @course
    @enrollments_with_reviews = @course.enrollments.reviewed
    @reviews =  @course.enrollments.reviewed.count
  end

  def new
    @course = Course.new
    authorize @course
  end

  def edit
    authorize @course
  end

  def analytics
    authorize @course, :owner?
  end

  def purchased
    @ransack_path= purchased_courses_path
    @ransack_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy( @ransack_courses.result.includes(:user))
    render 'index'
  end

  def pending_review
    @ransack_path= pending_review_courses_path
    @ransack_courses = Course.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)
  ).ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy( @ransack_courses.result.includes(:user))
    render 'index'
  end

  def my_courses
    @ransack_path= my_courses_courses_path
     @ransack_courses =  Course.where(user: current_user).ransack(params[:courses_search], search_key: :courses_search)
     @pagy, @courses = pagy( @ransack_courses.result.includes(:user))
    render 'index'
  end

  def create
    @course = Course.new(course_params)
    authorize @course
    @course.user = current_user
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @course.destroy
      @course.destroy
      authorize @course
      respond_to do |format|
        format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to courses_url, alert: "Course has subscribers, it can't be deleted." 
    end
  
  end

  def approve
    authorize @course, :approve?
    @course.update_attribute(:approved, true)
    redirect_to @course, notice: "Course was approved." 
  end

  def unapprove
    authorize @course, :approve?
    @course.update_attribute(:approved, false)
    redirect_to @course, alert: "Course was not approved, and is hidden." 
  end
  def unapproved
    @ransack_path= unapproved_courses_path
    @ransack_courses =  Course.published.unapproved.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render 'index'
  end

  private

    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :price, :language, :short_description, :level, :published )
    end
end
