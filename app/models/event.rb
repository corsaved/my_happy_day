class Event < ActiveRecord::Base
  attr_accessible :date, :title, :user, :recurring, :period

  validates :title, :date, presence: true

  belongs_to :user 
end
