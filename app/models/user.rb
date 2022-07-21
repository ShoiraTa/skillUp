class User < ApplicationRecord
  extend FriendlyId

  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :courses, dependent: :destroy
  has_many :enrollments, dependent: :destroy
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

  private
  def must_have_a_role
    unless roles.any? 
      errors.add(:roles, "must have at least one role")
    end
  end
end
