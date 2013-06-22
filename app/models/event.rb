class Event < ActiveRecord::Base
  attr_accessible :schedule, :title, :user

  validates :title, :schedule, presence: true

  belongs_to :user

  def init_schedule(params) 
    event_start_date = params[:event_start_date].to_date
    event_end_date = params[:event_end_date].to_date
    recurring_event = params[:recurring_event]
    period = params[:period]

    if recurring_event
      schedule = IceCube::Schedule.new(event_start_date) do |s|
        s.add_recurrence_rule IceCube::Rule.send(period).until(event_end_date) 
      end
    else
      schedule = IceCube::Schedule.new(event_start_date) 
    end 

    self.schedule = schedule.to_yaml
  end  
end
