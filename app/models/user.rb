class User < ApplicationRecord
  extend FriendlyId

  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify
  validate :must_have_a_role, on: :update

  after_create :assign_default_role
  friendly_id :email, use: :slugged

  def to_s
    email
  end

  def user_name
      self.email.split(/@/).first
  end

  def assign_default_role
    if User.count == 1
      self.add_role(:admin)if self.roles.blank?
      self.add_role(:student)
      self.add_role(:teacher)
    else
      self.add_role(:student)if self.roles.blank?
      self.add_role(:teacher)
    end
  end

  def online? 
    updated_at > 2.minutes.ago
  end

  def buy_course(course)
    self.enrollments.create(course: course, price: course.price)
  end

  def view_lesson(lesson)
    user_lesson = self.user_lessons.where(lesson: lesson)
    unless user_lesson.any?
      self.user_lessons.create(lesson: lesson)
    else
      user_lesson.first.increment(:impressions)
    end
  end

  private
  def must_have_a_role
    unless roles.any? 
      errors.add(:roles, "must have at least one role")
    end
  end
end
