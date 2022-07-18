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

  # For search fields
  LANGUAGES = [:"English", :"Russian", :"Polish", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  # Public Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
