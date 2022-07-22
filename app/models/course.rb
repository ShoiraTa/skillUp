class Course < ApplicationRecord
  include PublicActivity::Model
  extend FriendlyId

  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  validates :title, :short_description, :language, :price, :level, presence: :true
  validates :description, presence: :true

  has_rich_text :description
  friendly_id :title, use: :slugged

  tracked owner: Proc.new{ |controller, model| controller.current_user }

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
  
end
