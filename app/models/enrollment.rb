class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user
 
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  validates :user, :course, presence: true
  validate :cant_subscribe_to_own_course

  def to_s
    course.to_s
  end

  protected 

  def cant_subscribe_to_own_course
    if self.new_record?
      if user_id == course.user_id
        errors.add(:base, "You can't subscribe to your own course")
      end
    end
  end
end
