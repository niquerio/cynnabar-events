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
		params.require(:event).permit(:name, :start_date, :end_date, :facebook_event_link, 
      :pages_attributes => [ :id, :slug, :title, :body], 
      :contacts_attributes => [:id, :name, :job, :email], 
      :locations_attributes => [:id, :name, :address]    )
	end
end
