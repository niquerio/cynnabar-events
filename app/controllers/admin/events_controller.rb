class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  def edit
    @event = EditEventPresenter.new(Event.find(params[:id]))
  end
	def update
    @event = Event.find(params[:id])		
		if @event.update(event_params)
			redirect_to admin_user_index_path
			flash[:success] = 'Event successfully updated'
		else
			render 'edit'
		end
	end
  private
	def event_params
		params.require(:event).permit(:name, :facebook_event_link, :pages_attributes => [ :id, :slug, :title, :body]   )
	end
end
