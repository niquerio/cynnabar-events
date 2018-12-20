class Admin::EventSeriesController < ApplicationController
  def new
    @meta_event = MetaEvent.new
    @meta_event.events.build 
  end
  def create
    @meta_event = MetaEvent.new(meta_event_params) 
    if @meta_event.save
      redirect_to admin_user_index_path
    else
      render 'new'
    end
  end
  private
  def meta_event_params
    params.require(:meta_event).permit(:name, :slug, events_attributes: [:id, :name, :start_date, :end_date]) # This permits the kids params to be saved
  end
end
