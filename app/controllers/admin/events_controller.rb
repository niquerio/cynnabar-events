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
		my_params = params.require(:event).permit(:name, :start_date, :end_date, :facebook_event_link, 
      :pages_attributes => [ :id, :slug, :title, :body], 
      :contacts_attributes => [:id, :name, :job, :email], 
      :locations_attributes => [:id, :name, :address]    ).to_hash
    my_params["start_date"] = DateTime.parse(my_params["start_date"]).change(offset: '-5')
    my_params["end_date"] = DateTime.parse(my_params["end_date"]).change(offset: '-5', hour: 23, min: 59, sec: 59) 
    my_params
	end
end
