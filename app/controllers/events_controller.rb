class EventsController < BaseController
  before_filter :authenticate
  before_filter :authorize_event, :only => [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
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

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  # def show
  #   @event = Event.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @event }
  #   end
  # end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @method = :put
    @begin_date = YAML.load(@event.date).first.to_s
    @end_date = YAML.load(@event.date).last.to_s
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_attributes)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_attributes)
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private

  def authorize_event
    if not current_user == Event.find(params[:id]).user  
      redirect_to :root 
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
