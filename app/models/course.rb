class Course < ApplicationRecord
  include PublicActivity::Model
  extend FriendlyId

  belongs_to :user,  counter_cache: true
  # User.find_each{|user| User.reset_counters(user.id, :courses)}

  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :user_lessons, through: :lessons

  validates :title, :short_description, :language, :price, :level, presence: :true
  validates :description, presence: :true
  validates :title, uniqueness: :true

  has_rich_text :description
  friendly_id :title, use: :slugged

  tracked owner: Proc.new{ |controller, model| controller.current_user }

  scope :recent_courses, -> {limit(3).order(created_at: :desc)}
  scope :top_rated_courses, -> {limit(3).order(avg_rating: :desc,  created_at: :desc)}
  scope :popular_courses, -> {limit(3).order(enrollments_count: :desc,  created_at: :desc)}

  def to_s
    title
  end

  LANGUAGES = [:"English", :"Russian", :"Polish", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  def bought_course(user)
    self.enrollments.where(user_id: [user.id], course_id:[self.id]).empty?
  end

  def current_user_progress(user)
    unless self.lessons_count == 0
      user_lessons.where(user: user).count / self.lessons_count.to_f * 100
    end
  end
  
  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :avg_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :avg_rating,(0)
    end
  end
end
