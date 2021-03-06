class Enrollment < ApplicationRecord
  extend FriendlyId

  belongs_to :course, counter_cache: true
    # Course.find_each{|course| Course.reset_counters(course.id, :enrollments)}
  belongs_to :user, counter_cache: true
   # User.find_each{|course| Course.reset_counters(course.id, :enrollments)}
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  validates_presence_of :review, if: :rating?
  validates_presence_of :rating, if: :review?
  validates :user, :course, presence: true
  validate :cant_subscribe_to_own_course
  friendly_id :to_s, use: :slugged

  scope :pending_review, -> {where(rating: [0, nil, ""], review: [0, nil, ""])}
  scope :reviewed, -> {where.not(review: [0, nil, ""])}
  scope :latest_good_reviews, -> {order(rating: :desc, created_at: :desc).limit(3)}

  after_save do 
    unless rating.nil? || rating.zero?
      course.update_rating
    end
  end

  after_destroy do
    course.update_rating
  end 

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

# For reference





