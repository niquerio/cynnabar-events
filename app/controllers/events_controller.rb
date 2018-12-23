class EventsController < ApplicationController
  def index
    @event = SimpleEventPresenter.new(Event.active(params[:slug]))
  end
  def show
    @event = SimpleEventPresenter.new(Event.find(params[:id]))
    render :index
  end
end
