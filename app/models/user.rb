class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :courses, dependent: :destroy
  def to_s
    email
  end

  def user_name
      self.email.split(/@/).first
  end

  # Rolify assign role after user created
  after_create :assign_default_role

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

  # check if online? 
  def online? 
    updated_at > 2.minutes.ago
  end

  # Friendly id
  extend FriendlyId
  friendly_id :email, use: :slugged

  validate :must_have_a_role, on: :update
  private
  def must_have_a_role
    unless roles.any? 
      errors.add(:roles, "must have at least one role")
    end
  end
end
