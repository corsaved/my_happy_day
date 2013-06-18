class Event < ActiveRecord::Base
  attr_accessible :date, :period, :title

  validates :title, :date, presence: true 
end
