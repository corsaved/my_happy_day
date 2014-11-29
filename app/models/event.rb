class Event < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user
  has_one :scheduler, as: :schedulable, class_name: 'RecurringScheduler::Scheduler', dependent: :destroy

  assign_recurring_action :asdf

  def asdf
  end

  def occurs_on?(day)
    return scheduler.occurs_on? day if scheduler

    false
  end
end
