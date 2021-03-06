class Lesson < ApplicationRecord

  has_many :user_lessons, dependent: :destroy
  belongs_to :course, counter_cache: true
  # Course.find_each{|user| Course.reset_counters(user.id, :lessons)}
  validates :title, :content, :course, presence: true
  has_rich_text :content
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Public Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  # Ranking lessons for drag and drop
  include RankedModel
  ranks :row_order, :with_same => :course_id
  def prev_lesson
    course.lessons.where("row_order < ?", row_order).order(:row_order).last
  end
  def next_lesson
    course.lessons.where("row_order > ?", row_order).order(:row_order).first
  end
  def to_s
    title
  end

  def viewed(user)
    self.user_lessons.where(user: user).present?
    # self.user_lessons.where(user_id: [:user_id], lesson_id: [:lesson_id]).empty?
  end
end
