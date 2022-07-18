class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: :true
  validates :description, presence: :true

  has_rich_text :description

  belongs_to :user
  def to_s
    title
  end

  # Friendly id
  extend FriendlyId
  friendly_id :title, use: :slugged
end
