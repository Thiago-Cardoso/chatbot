class Company < ActiveRecord::Base
  validates_presence_of :name #required member for company
  #company has many faqs and hashtags
  has_many :faqs
  has_many :hashtags
end
