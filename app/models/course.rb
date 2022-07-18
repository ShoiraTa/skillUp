class Course < ApplicationRecord
  validates :title, presence: :true
  validates :description, presence: :true
  has_rich_text :description

  belongs_to :user
  def to_s
    title
  end
end
