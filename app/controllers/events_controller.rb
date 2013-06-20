class EventsController < BaseController
  before_filter :authenticate
  before_filter :authorize_event, :only => [:edit, :update, :destroy]

  def index
    @events = Event.all
    @events_by_date = {}
    range_to_show.each do |day|
      @events_by_date[day] = []
      @events.each do |event|
        @events_by_date[day] << event if YAML.load(event.date).include? day
      end
    end  
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    @method = :put
    @begin_date = YAML.load(@event.date).first.to_s
    @end_date = YAML.load(@event.date).last.to_s
  end

  def create
    @event = Event.new(event_attributes)
      if @event.save
        redirect_to events_path, :flash => { :success => "Event was succesfully created" }
      else
        render action: "new"
      end
  end

  def update
    @event = Event.find(params[:id])
      if @event.update_attributes(event_attributes)
        redirect_to events_path, :flash => { :success => "Event was succesfully updated" }
      else
        render action: "edit"
      end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :flash => { :success => "Event was succesfully deleted" }
  end

  private

  def authorize_event
    if not current_user == Event.find(params[:id]).user  
      redirect_to :root, :flash => { :error => "You do not have permissions to this action" }
    end  
  end

  def range_to_show 
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    first = date.beginning_of_month.beginning_of_week(:monday)
    last = date.end_of_month.end_of_week(:monday)
    (first..last).to_a
  end

  def event_attributes
    event_title = params[:event_title]
    event_date = params[:event_date].to_date
    event_end_date = params[:event_end_date].to_date
    recurring_event = params[:recurring_event]
    period = params[:period]

    event_ocassions_date = []
    next_ocassion = "next_#{period}"
    if not recurring_event 
      event_ocassions_date << event_date
    else
      until event_date > event_end_date do
        event_ocassions_date << event_date
        event_date = event_date.send(next_ocassion)
      end
    end  
    event_ocassions_date_in_yaml = event_ocassions_date.to_yaml

    result = { :title => event_title,
               :user => current_user,
               :date => event_ocassions_date_in_yaml,
               :recurring => recurring_event,
               :period => period  
              }
  end  
end
