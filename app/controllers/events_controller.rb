class EventsController < ApplicationController
  def index
    @event = Event.active(params[:slug])
  end
  def show
    @event = Event.find(params[:id])
    render :index
  end
end
