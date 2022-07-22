class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  # Course.find_each{|user| Course.reset_counters(user.id, :lessons)}

  validates :title, :content, :course, presence: true
  has_rich_text :content
  extend FriendlyId
  friendly_id :title, use: :slugged

    # Public Activity
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }

    def to_s
      title
    end
end
