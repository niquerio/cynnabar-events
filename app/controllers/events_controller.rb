class EventsController < ApplicationController
  def index
    @event = Event.active(params[:slug])
  end
end
