class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer #required field question and answer

  has_many :faq_hashtags #faq has many hashtags
  has_many :hashtags, through: :faq_hashtags #because have a table in the middle
  belongs_to :company
end
