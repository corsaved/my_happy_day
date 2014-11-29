class ApplicationController < ActionController::Base
  protect_from_forgery

  helper RecurringScheduler::Engine.helpers
end
